import 'package:eduflex/app.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() async {
  // widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // getx local storage
  await GetStorage.init();

  int appId = 646832829;
  String appSignId =
      '37069f0f58db671091a3a0e7dcd51250986c5e4c5507b9237c96f131c9c82192';

  ZIMAppConfig appConfig = ZIMAppConfig();

  appConfig.appID = appId;
  appConfig.appSign = appSignId;

  ZIM.create(appConfig);

  //initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationReposotiry());
  });

  // load all material design/ theme/ localization /bindings
  runApp(const MyApp());
}
