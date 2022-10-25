import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mygetxchat/app/modules/auth/widgets/auth_form.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('AuthView'),
          centerTitle: true,
        ),
        body: Authform());
  }
}
