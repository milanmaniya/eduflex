import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  final storge = GetStorage();

  Future<void> saveData(String key, dynamic data) async {
    await storge.write(key, data);
  }

  dynamic readData(String key) {
    storge.read(key);
  }

  Future<void> clearAllData() async {
    await storge.erase();
  }

  Future<void> removeData(String key) async {
    await storge.remove(key);
  }
}
