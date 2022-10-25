import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mygetxchat/app/modules/auth/controllers/auth_controller.dart';

class UserImagePicker extends StatefulWidget {
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final con = Get.find<AuthController>();
  File? pimage;
  void pickimage() async {
    final pickedimage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    File kimage = File((pickedimage?.path)!);

    setState(() {
      pimage = kimage;
    });
    con.pickimage(pimage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pimage != null ? FileImage(pimage as File) : null,
        ),
        TextButton.icon(
            onPressed: pickimage,
            icon: Icon(Icons.image),
            label: Text('add image')),
      ],
    );
  }
}
