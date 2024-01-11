import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localStroage = GetStorage();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                SplashService().navigate();
              });
            },
            icon: const Icon(Iconsax.activity_outline),
          ),
        ],
      ),
      body: Center(
        child: Text(
          localStroage.read('Screen'),
        ),
      ),
    );
  }
}
