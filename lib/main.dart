import 'dart:developer';
import 'package:eduflex/app.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // getx local storage
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ),
  );

  //initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) async {
    Get.put(AuthenticationReposotiry());
    var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'eduFlex',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'EduFlex',
    );
    log(result.toString());
  });

  runApp(const MyApp());
}
