import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneauth/common/widgets/appbar/appbar.dart';
import 'package:phoneauth/features/authentication/screens/otp_screen/widgets/otp_field.dart';
import 'package:phoneauth/utils/constants/colors.dart';
import 'package:phoneauth/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../personalization/home/home.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text("We've sent a verification code to"),
                const Text('+91 7980030764'),
                const SizedBox(height: TSizes.spaceBtwSections),
                const OTPfield(),
                const SizedBox(height: TSizes.spaceBtwItems * 2),
                const Text(
                  "Resend OTP in 26",
                  style: TextStyle(color: TColors.darkerGrey),
                ),
                const SizedBox(height: TSizes.spaceBtwItems * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: () =>
                    //      controller.emailAndPasswordSignIn(),
                    onPressed: () => Get.offAll(() => const HomeScreen()),
                    child: const Text(TTexts.proceed),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
