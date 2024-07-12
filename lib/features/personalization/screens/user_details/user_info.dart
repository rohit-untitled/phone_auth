import 'package:flutter/material.dart';
import 'package:phoneauth/common/widgets/appbar/appbar.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/user_header.dart';
import 'widgets/username_form.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'User Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: TSizes.spaceBtwSections),

              // title
              UserHeader(),

              // form
              UserNameForm(),
            ],
          ),
        ),
      ),
    );
  }
}
