import 'package:eduflex/binding.dart';
import 'package:eduflex/to_csv/basic.dart';
import 'package:eduflex/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
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
      home: const BasicScreen(),
    );
  }
}
