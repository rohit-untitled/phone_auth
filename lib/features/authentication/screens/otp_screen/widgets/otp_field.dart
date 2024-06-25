import 'package:flutter/material.dart';
import 'package:phoneauth/utils/constants/colors.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OTPfield extends StatefulWidget {
  const OTPfield({super.key});

  @override
  _OTPfieldState createState() => _OTPfieldState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _OTPfieldState extends State<OTPfield> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = TColors.black;
    const errorColor = TColors.error;
    const fillColor = TColors.softGrey;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 64,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          setState(() => showError = pin != '5555');
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 60,
          width: 60,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
