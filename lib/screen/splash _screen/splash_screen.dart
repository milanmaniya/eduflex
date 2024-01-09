import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashService().navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: TColor.white,
      body: Center(
        child: Image.asset(
          'assets/logo/EduFlex.png',
          height: 400,
          width: 400,
        ),
      ),
    );
  }
}
