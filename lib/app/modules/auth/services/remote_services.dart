import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteServices {
  static final auth = FirebaseAuth.instance;

  static Future<UserCredential> signup(
      String email, String password, String username) async {
    return auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> signin(
      String email, String password, String username) async {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
