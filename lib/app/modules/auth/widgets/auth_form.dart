import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygetxchat/app/modules/auth/controllers/auth_controller.dart';
import 'package:mygetxchat/app/modules/auth/widgets/user_image_picker.dart';

class Authform extends StatefulWidget {
  const Authform({
    Key? key,
  }) : super(key: key);

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final con = Get.put(AuthController());
  final mykey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  bool islogin = true;
  void submit() {
    FocusScope.of(context).unfocus();
    final isvalid = mykey.currentState!.validate();
    if (con.userimagefile == null && !islogin) {
      Get.showSnackbar(GetSnackBar(
        message: 'please pick up an image',
      ));
      return;
    }
    if (isvalid) {
      mykey.currentState!.save();
      con.submitform(
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
          usernamecontroller.text.trim(),
          islogin,
          con.userimagefile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: mykey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!islogin) UserImagePicker(),
                TextFormField(
                  key: ValueKey('email'),
                  onSaved: (value) {
                    emailcontroller.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'please enter valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email address',
                  ),
                ),
                if (!islogin)
                  TextFormField(
                    key: ValueKey('username'),
                    onSaved: (value) {
                      usernamecontroller.text = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'please enter valid  username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (value) {
                    passwordcontroller.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'password must be 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                con.isloading.value
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: submit,
                        child: Text(islogin ? 'login' : 'signup')),
                con.isloading.value
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            islogin = !islogin;
                          });
                        },
                        child: Text(islogin ? 'create new account' : 'login'))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
