import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phoneauth/features/authentication/screens/login/login.dart';
import 'package:phoneauth/features/authentication/screens/onboarding/onboarding.dart';
import 'package:phoneauth/utils/popups/loaders.dart';
import '../../features/authentication/models/user_model.dart';
import '../../features/personalization/screens/home.dart';
import '../../features/personalization/screens/user_details/username_form.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  // called from main.dart on app launch
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  // setting initial screen
  void _setInitialScreen(User? user) {
    // local storage
    deviceStorage.writeIfNull('IsFirstTime', true);
    bool isFirstTime = deviceStorage.read('IsFirstTime') as bool;

    if (isFirstTime) {
      deviceStorage.write('IsFirstTime', false);
      Get.offAll(() => const OnBoardingScreen());
    } else {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    }
  }

  // phone authentication function
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _auth.signInWithCredential(credential);
        } catch (e) {
          TLoaders.customToast(message: 'Automatic sign-in failed. Try again.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          TLoaders.errorSnackBar(
              title: 'The provided phone number is not valid');
        } else {
          TLoaders.customToast(message: 'Something went wrong. Try again.');
        }
      },
    );
  }

  // check existing user
  Future<bool> checkExistingUser(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      return userDoc.exists;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error checking user existence');
      return false;
    }
  }

  // save data to the firebase
  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error saving user data');
    }
  }

  // get data from the firebase

  Future<UserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        // print('User data retrieved: ${userDoc.data()}'); // Debug print
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        // print('User document does not exist'); // Debug print
        return null;
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error retrieving user data');
      // print('Error retrieving user data: $e'); // Debug print
      return null;
    }
  }

  // update username
  Future<void> updateUsername(String userId, String username) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String phoneNumber = user.phoneNumber ?? '';

        await _firestore.collection('users').doc(userId).set({
          'username': username,
          'id': userId,
          'phoneNumber': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
        TLoaders.customToast(message: 'User data saved successfully');
      } else {
        TLoaders.errorSnackBar(
            title: 'Error', message: 'User is not logged in');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error updating user data');
    }
  }

  // verify otp
  Future<void> verifyOTP({
    required String otp,
    required Function onSuccess,
  }) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );

      if (credentials.user != null) {
        // Call onSuccess callback
        onSuccess();

        // Check if the user exists in Firestore
        bool userExists = await checkExistingUser(credentials.user!.uid);

        if (userExists) {
          // User exists, navigate to home screen
          Get.offAll(() => const HomeScreen());
        } else {
          // User doesn't exist, handle accordingly
          Get.offAll(
            () => UserNameForm(
              onSubmit: (username) async {
                await updateUsername(credentials.user!.uid, username);
                Get.offAll(() => const HomeScreen());
              },
            ),
          );
        }
      } else {
        TLoaders.errorSnackBar(
          title: 'Invalid OTP. Please try again.',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Invalid OTP. Please try again.',
      );
    }
  }

  // logout
  Future<void> logout() async {
    try {
      _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
