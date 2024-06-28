import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phoneauth/features/authentication/screens/login/login.dart';
import 'package:phoneauth/features/authentication/screens/onboarding/onboarding.dart';
import 'package:phoneauth/utils/popups/loaders.dart';

import '../../features/personalization/home/home.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
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

  // function
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign in automatically when the verification is completed
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

  // verify otp
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value, 
          smsCode: otp,
        ),
      );
      return credentials.user != null;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Invalid OTP. Please try again.');
      return false;
    }
  }

  //logout
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
