import 'package:flutter/material.dart';
import 'package:phoneauth/utils/constants/sizes.dart';
import '../../../../common/styles/spacing_styles.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import 'widgets/terms_and_condition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: TSizes.spaceBtwSections * 3),
              // logo title
              TLoginHeader(),

              // form
              TLoginForm(),

              // footer
              TermsAndConditions(),
            ],
          ),
        ),
      ),
    );
  }
}
