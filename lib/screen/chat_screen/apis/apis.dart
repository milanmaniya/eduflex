import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/chat_screen/model/chat_user_model.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class APIS {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final localStorage = GetStorage();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> sendPushNotification(
      String pushToken, String message, String title) async {
    try {
      final body = {
        "to": pushToken,
        "notification": {
          "title": title,
          "body": message,
          "android_channel_id": "eduFlex",
        }
      };

      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAAamlAXiE:APA91bERFLoxL4OMm4AvxAikpUJ-Ht29n1yrpkaOskCI3gRa8gQ-8BSGDzeByQ38fsI4R9Lci3bHnWxLcyUlFZCgxDsjtrUNxmbpJ9R1GjI565xWcZUdtz7HhdziawdePeCZuh8EtUVA'
        },
        body: jsonEncode(body),
      );
      log(response.statusCode.toString());
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap!', message: e);
    }
  }

  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((value) {
      Logger().i(value.toString());
      if (value != null) {
        _firebaseFirestore
            .collection(localStorage.read('Screen'))
            .doc(_auth.currentUser!.uid)
            .update({
          'pushToken': value,
        });
      }
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUserId() {
    return _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .doc(_auth.currentUser!.uid)
        .collection('my_users')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(
      List<String> userIds) {
    Logger().i('My User Id: $userIds');

    return _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .where('id', isNotEqualTo: _auth.currentUser!.uid)
        // .where('id', whereIn: userIds)
        .snapshots();
  }

  static Future<void> sendFirstMessage({
    required String id,
    required String msg,
    required Type type,
    required String title,
    required String pushToken,
  }) async {
    await _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .doc(id)
        .collection('my_users')
        .doc(_auth.currentUser!.uid)
        .set({}).then((value) {
      sendMessage(
          id: id, msg: msg, type: type, title: title, pushToken: pushToken);
    });
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
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage({
    required String id,
    required String msg,
    required Type type,
    required String title,
    required String pushToken,
  }) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
      fromId: _auth.currentUser!.uid,
      toId: id,
      message: msg,
      read: '',
      sent: time,
      type: type,
    );

    final ref = _firebaseFirestore
        .collection('chats/${getConversationId(id)}/messages');

    await ref.doc(time).set(message.toJson()).then((value) {
      sendPushNotification(pushToken, type == Type.text ? msg : 'image', title);
    });
  }

  static Future<void> updateMessageReadStatus(Message message) async {
    _firebaseFirestore
        .collection('chats/${getConversationId(message.fromId)}/messages')
        .doc(message.sent)
        .update({
      'read': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  static Future<void> deleteMessage(Message message) async {
    await _firebaseFirestore
        .collection('chats/${getConversationId(message.toId)}/messages')
        .doc(message.sent)
        .delete();
    if (message.type == Type.image) {
      await _firebaseStorage.refFromURL(message.message).delete();
    }
  }

  static Future<void> updateMessage(
      Message message, String updatedMessage) async {
    await _firebaseFirestore
        .collection('chats/${getConversationId(message.toId)}/messages')
        .doc(message.sent)
        .update({'message': updatedMessage});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(String id) {
    return _firebaseFirestore
        .collection('chats/${getConversationId(id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendChatImage(
      String id, File file, Type type, String title, String pushToken) async {
    final extension = file.path.split('.').last;
    Logger().i(extension.toString());
    final ref = _firebaseStorage.ref().child(
        'images/${getConversationId(id)}/${DateTime.now().millisecondsSinceEpoch}.$extension');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$extension'))
        .then((p0) {
      Logger().i('Data Transfered: ${p0.bytesTransferred / 1000} kb');
    });

    final downloadUrl = await ref.getDownloadURL();

    await APIS.sendMessage(
      id: id,
      msg: downloadUrl,
      type: type,
      title: title,
      pushToken: pushToken,
    );
  }

  static Future<bool> addChatUser(String email) async {
    final data = await _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .where('email', isEqualTo: email)
        .get();

    if (data.docs.isNotEmpty && data.docs.first.id != _auth.currentUser!.uid) {
      _firebaseFirestore
          .collection(localStorage.read('Screen'))
          .doc(_auth.currentUser!.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      {required String chatUserID}) {
    return _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .where('id', isEqualTo: chatUserID)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    _firebaseFirestore
        .collection(localStorage.read('Screen'))
        .doc(_auth.currentUser!.uid)
        .update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}
