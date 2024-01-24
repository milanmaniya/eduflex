import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class APIS {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final localStorage = GetStorage();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .where('id', isNotEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

  static Future<void> updateProfilePicture(File file) async {
    final extension = file.path.split('.').last;
    Logger().i(extension.toString());
    final ref = _firebaseStorage
        .ref()
        .child('profileImage/${_auth.currentUser!.uid}.$extension');
    await ref.putFile(file).then((p0) {
      Logger().i(p0.bytesTransferred / 1000);
    });

    final downloadUrl = await ref.getDownloadURL();

    _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .doc(_auth.currentUser!.uid)
        .update({
      'image': downloadUrl,
    });
  }

  // chat releated functions

  static getConversationId(String id) =>
      _auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${_auth.currentUser!.uid}_$id'
          : '${id}_${_auth.currentUser!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      {required String id}) {
    return _firebaseFirestore
        .collection('chats/${getConversationId(id)}/messages')
        .snapshots();
  }

  static Future<void> sendMessage(String id, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
      fromId: _auth.currentUser!.uid,
      toId: id,
      message: msg,
      read: '',
      sent: time,
      type: Type.text,
    );

    final ref = _firebaseFirestore
        .collection('chats/${getConversationId(id)}/messages');

    ref.doc(time).set(message.toJson());
  }
}
