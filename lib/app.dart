import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   // themeMode: ThemeMode.system,
    //   theme: TAppTheme.lightTheme,
    //   // darkTheme: TAppTheme.darkTheme,
    //   initialBinding: GeneralBindings(),
    //   home: const Scaffold(
    //     backgroundColor: TColors.primary,
    //     body: Center(
    //       child: CircularProgressIndicator(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      home: const OnBoardingScreen(),
    );
  }
}
