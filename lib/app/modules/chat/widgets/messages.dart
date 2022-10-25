import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:mygetxchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:mygetxchat/app/modules/chat/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  final con = Get.find<ChatController>();
  Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: con.fetchmessages(),
        builder: (
          ctx,
          snp,
        ) {
          if (snp.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                reverse: true,
                itemCount: snp.data?.docs.length,
                itemBuilder: (ctx, index) {
                  return MessageBubble(
                    imageurl: snp.data?.docs[index]['userimage'],
                    username: snp.data?.docs[index]['username'],
                    message: snp.data?.docs[index]['text'],
                    isme: snp.data?.docs[index]['userid'] ==
                        FirebaseAuth.instance.currentUser?.uid,
                  );
                });
          }
        });
  }
}
