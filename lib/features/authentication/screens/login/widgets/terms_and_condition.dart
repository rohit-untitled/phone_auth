import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "By continuing, you agree to our ",
        style: TextStyle(
            fontSize: 10,
            color: Colors.black.withOpacity(0.7),
            fontFamily: 'Poppins'),
        children: [
          TextSpan(
            text: "Terms of service",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontFamily: 'Poppins'),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle terms of service click
                // print("Terms of Service Clicked");
              },
          ),
          const TextSpan(
            text: " & ",
          ),
          TextSpan(
            text: "Privacy policy",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontFamily: 'Poppins'),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle privacy policy click
                // print("Privacy Policy Clicked");
              },
          ),
        ],
      ),
    );
  }
}
