import 'package:eduflex/binding.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:eduflex/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: GeneralBinding(),
        debugShowCheckedModeBanner: false,
        darkTheme: TAppTheme.darkTheme,
        theme: TAppTheme.lightTheme,
        themeMode: ThemeMode.system,
        home: const WelcomeScreen());
  }
}
