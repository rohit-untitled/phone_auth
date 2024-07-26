import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:phoneauth/utils/popups/loaders.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../data/authentication/authentication_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import 'widgets/user_header.dart';

class UserNameForm extends StatefulWidget {
  final Function(String) onSubmit;

  const UserNameForm({super.key, required this.onSubmit});

  @override
  State<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends State<UserNameForm> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      final userId = AuthenticationRepository.instance.firebaseUser.value?.uid;

      if (userId != null) {
        try {
          await AuthenticationRepository.instance
              .updateUsername(userId, username);
          widget.onSubmit(username);
        } catch (e) {
          TLoaders.errorSnackBar(
              title: 'Error saving username. Please try again');
        }
      } else {
        TLoaders.errorSnackBar(title: 'User ID is null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'User Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: TSizes.spaceBtwSections),

              // title
              const UserHeader(),

              // form fields
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      // username textfield
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) =>
                            TValidator.validateEmptyText('username', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: TTexts.username,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      // continue button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text(TTexts.proceed),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
