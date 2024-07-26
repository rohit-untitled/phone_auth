import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phoneauth/data/authentication/authentication_repository.dart';
import 'package:phoneauth/features/personalization/screens/home.dart';
import 'package:phoneauth/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:phoneauth/utils/exceptions/format_exceptions.dart';
import 'package:phoneauth/utils/exceptions/platform_exceptions.dart';
import 'package:phoneauth/utils/popups/loaders.dart';
import '../../../personalization/screens/user_details/username_form.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    try {
      // Check for internet connectivity
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        TLoaders.errorSnackBar(
            title: 'Oh Snap', message: 'No internet connection');
        return;
      }

      // Verify OTP and handle user navigation
      await AuthenticationRepository.instance.verifyOTP(
        otp: otp,
        onSuccess: () {
          // OTP verified successfully, proceed with user existence check and navigation
          _navigateBasedOnUserExistence();
        },
      );
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

  void _navigateBasedOnUserExistence() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      bool userExists = await AuthenticationRepository.instance
          .checkExistingUser(currentUser.uid);
      if (userExists) {
        Get.offAll(() => const HomeScreen());
      } else {
        // Navigate to the username prompt screen if the user does not exist
        Get.offAll(() => UserNameForm(
              onSubmit: (username) async {
                await AuthenticationRepository.instance
                    .updateUsername(currentUser.uid, username);
                Get.offAll(() => const HomeScreen());
              },
            ));
      }
    } else {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not found. Please try again.',
      );
    }
  }
}


