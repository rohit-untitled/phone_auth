import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(TImages.appLogo),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: TColors.primary,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: TSizes.md),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: TColors.black.withOpacity(0.8),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}