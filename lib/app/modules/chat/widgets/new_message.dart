import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:mygetxchat/app/modules/chat/controllers/chat_controller.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredmessage = '';
  final con = Get.find<ChatController>();
  final mtc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: mtc,
            onChanged: (value) {
              setState(() {
                enteredmessage = value;
              });
            },
            decoration: InputDecoration(label: Text('send a message')),
          )),
          IconButton(
            onPressed: enteredmessage.trim().isEmpty
                ? null
                : () {
                    con.addmessages(enteredmessage);
                    mtc.clear();
                  },
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
    );
  }
}
