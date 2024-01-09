import 'package:eduflex/app.dart';
import 'package:eduflex/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // widget binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // getx local storage
  await GetStorage.init();

  //initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // load all material design/ theme/ localization /bindings
  runApp(const MyApp());
}
