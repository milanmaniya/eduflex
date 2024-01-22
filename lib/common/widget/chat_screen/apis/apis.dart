import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class APIS {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final localStorage = GetStorage();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .snapshots();
  }
}
