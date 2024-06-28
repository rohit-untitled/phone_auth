import 'package:flutter/material.dart';
import 'package:phoneauth/data/repositories/authentication_repository.dart';
import 'package:phoneauth/utils/constants/sizes.dart';
import 'package:phoneauth/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hii Rohit, this is phone authentication app.'),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: AuthenticationRepository.instance.logout,
                    child: const Text(TTexts.logout)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
