import 'package:get/get.dart';
import 'package:phoneauth/data/repositories/authentication_repository.dart';
import 'package:phoneauth/features/personalization/home/home.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => const HomeScreen()): Get.back();
  }
}