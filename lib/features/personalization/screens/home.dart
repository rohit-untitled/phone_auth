import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneauth/utils/constants/sizes.dart';
import 'package:phoneauth/utils/constants/text_strings.dart';
import '../../../data/authentication/authentication_repository.dart';
import '../../authentication/controllers/homescreen/homescreen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(HomeScreenController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Center(
          child: Obx(() {
            if (controller.username.isEmpty || controller.phoneNumber.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Hi ${controller.username}, this is a phone authentication app.'),
                  Text('Phone Number: ${controller.phoneNumber}'),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: AuthenticationRepository.instance.logout,
                        child: const Text(TTexts.logout)),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
