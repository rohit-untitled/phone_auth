import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phoneauth/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: THelperFunctions.screenWidth() * 0.8,
            // height: THelperFunctions.screenHeight() * 0.7,
          ),
          const SizedBox(height: TSizes.spaceBtwSections * 2),
          Text(title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: TColors.primary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TColors.black.withOpacity(0.6), fontFamily: 'Poppins'),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
