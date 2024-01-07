import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/network_manager/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager());
    Get.lazyPut(() => AuthenticationReposotiry());
  }
}
