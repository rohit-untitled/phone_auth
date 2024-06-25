import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controllers.dart';
import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController()); // to create new instance
    return Scaffold(
      body: Stack(
        children: [
          // horizontal scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage4,
                title: TTexts.onBoardingTitle4,
                subtitle: TTexts.onBoardingSubTitle4,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage5,
                title: TTexts.onBoardingTitle5,
                subtitle: TTexts.onBoardingSubTitle5,
              ),
            ],
          ),
          //skip button
          const OnBoardingSkip(),
          //dot navigation indicator
          const OnboardingDotNavigation(),
          //circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
