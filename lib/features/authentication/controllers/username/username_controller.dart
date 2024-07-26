import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneauth/data/authentication/authentication_repository.dart';
import 'package:phoneauth/utils/popups/loaders.dart';

class UsernameController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> submitForm(Function(String) onSubmit) async {
    if (formKey.currentState?.validate() ?? false) {
      final username = usernameController.text;
      final userId = AuthenticationRepository.instance.firebaseUser.value?.uid;

      if (userId != null) {
        try {
          await AuthenticationRepository.instance.updateUsername(userId, username);
          onSubmit(username);
        } catch (e) {
          TLoaders.errorSnackBar(title: 'Error', message: 'Error saving username. Please try again.');
        }
      } else {
        TLoaders.errorSnackBar(title: 'Error', message: 'User ID is null');
      }
    }
  }
}
