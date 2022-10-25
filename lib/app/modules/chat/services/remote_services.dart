import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteServices {
  static Stream<QuerySnapshot<Map<String, dynamic>>>? fetchmessages() {
    try {
      return FirebaseFirestore.instance
          .collection('chats/25cWYXlsIPwJTNjy0Kv0/messages')
          .orderBy('createdat', descending: true)
          .snapshots();
    } on Exception catch (e) {
      return null;
    }
  }

  static Future<void> addmessages(String m) async {
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    try {
      FirebaseFirestore.instance
          .collection('chats/25cWYXlsIPwJTNjy0Kv0/messages')
          .add({
        'text': m,
        'createdat': Timestamp.now(),
        'userid': user?.uid,
        'username': userdata['username'],
        'userimage': userdata['image_url'],
      });
    } on Exception catch (e) {}
  }
}
