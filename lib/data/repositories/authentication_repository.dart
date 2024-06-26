import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phoneauth/features/authentication/screens/login/login.dart';
import 'package:phoneauth/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();

  // called from main.dart on app launch

  @override
  void onReady() {
    screenRedirect();
  }

  // function to show relevant screen
  screenRedirect() async {
    // local storage
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(
            () => const OnBoardingScreen(),
          );
  }
}
