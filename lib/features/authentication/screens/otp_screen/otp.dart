import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneauth/common/widgets/appbar/appbar.dart';
import 'package:phoneauth/features/authentication/controllers/otp/otp_controller.dart';
import 'package:phoneauth/features/authentication/screens/otp_screen/widgets/otp_field.dart';
import 'package:phoneauth/utils/constants/colors.dart';
import 'package:phoneauth/utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'OTP verification',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: TSizes.spaceBtwItems),
                const Text(
                  "We've sent a verification code to",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                OTPfield(
                  onCompleted: (code) {
                    otp = code;
                    OTPController.instance.verifyOTP(otp);
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
               
                const Text(
                  "Resend OTP in 26",
                  style: TextStyle(color: TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.spaceBtwItems * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      OTPController.instance.verifyOTP(otp);
                    },
                    child: const Text(TTexts.proceed),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
