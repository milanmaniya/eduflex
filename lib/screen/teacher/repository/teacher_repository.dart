import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/model/teacher_modal.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:get/get.dart';

class TeacherRepository extends GetxController {
  static TeacherRepository get instance => Get.find();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // to save and add teacher data in firebase firestore
  Future<void> saveTeacherData(Teacher teacher) async {
    try {
      await _firebaseFirestore
          .collection('Teacher')
          .doc(teacher.id)
          .set(teacher.toJson());
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Save Teacher Data',
          message: 'Something went wrong. Please try again');
    }
  }



  
}
