import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:phoneauth/features/authentication/screens/otp_screen/otp.dart';
import 'package:phoneauth/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());
    return Form(
      // key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
            // TextFormField(
            //   // controller: controller.email,
            //   // validator: (value) => TValidator.validateEmail(value),
            //   decoration: const InputDecoration(
            //       prefixIcon: Icon(Iconsax.direct_right),
            //       labelText: TTexts.phoneNo),
            // ),

            // phone number text field
            TextField(
              keyboardType: TextInputType.phone,
              cursorColor: TColors.primary,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
                hintStyle: TextStyle(
                    color: Colors.grey.shade400, fontFamily: 'Poppins'),
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Text(
                    '+91',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: TColors.darkGrey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: TColors.darkGrey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: TColors.darkGrey,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            //sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: () =>
                //      controller.emailAndPasswordSignIn(),
                onPressed: () => Get.to(() => const OtpScreen()),
                child: const Text(TTexts.proceed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
