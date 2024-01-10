import 'package:eduflex/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // getx local storage
  await GetStorage.init();

  //initialize firebase & authentication repository
  await Firebase.initializeApp();

  // load all material design/ theme/ localization /bindings
  runApp(const MyApp());
}
