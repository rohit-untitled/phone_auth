
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';


class TFullScreenLoader {
  // opens a full screen loading dialog with text and animation

  // text the message to be shown
  // animation the lottie animation to be seen

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible:
          false, // the dialog cant be dismissed by tapping outsidee it
      builder: (_) => PopScope(
        canPop: false, // disable popping with back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)? TColors.dark: TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoaderWidget(text:text, animation:animation),
            ],
          ),
        ),
      ),
    );
  }

  // stop the currently open loading dialog -- no return
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
