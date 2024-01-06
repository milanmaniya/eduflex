import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eduflex/binding.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:eduflex/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBinding(),
      debugShowCheckedModeBanner: false,
      darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: AnimatedSplashScreen(
        splash: 'assets/logo/EduFlex.png',
        centered: true,
        splashIconSize: 550,
        animationDuration: const Duration(
          seconds: 2,
        ),
        duration: 2000,
        nextScreen: const WelcomeScreen(),
      ),
    );
  }
}
