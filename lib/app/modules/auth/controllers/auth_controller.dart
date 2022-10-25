import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygetxchat/app/modules/auth/services/remote_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController extends GetxController {
  void submitform(String email, String password, String username, bool islogin,
      File image) async {
    final authresult;
    try {
      stoploading();
      if (islogin) {
        authresult = await RemoteServices.signin(email, password, username);
      } else {
        authresult = await RemoteServices.signup(email, password, username);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authresult.user.uid + '.jpg');
        await ref.putFile(
          image,
        );
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user.uid)
            .set({'username': username, 'email': email, 'image_url': url});
      }
    } on Exception catch (e) {
      var msg = 'error occured';
      if (e.toString().isNotEmpty) {
        msg = e.toString();
      }
      Get.showSnackbar(GetSnackBar(
        message: msg,
        backgroundColor: Colors.green,
      ));
    }
    isloading.value = false;
  }

  File? userimagefile;
  void pickimage(File? pimage) {
    userimagefile = pimage;
  }

  RxBool isloading = false.obs;
  void stoploading() {
    isloading.value = true;
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
