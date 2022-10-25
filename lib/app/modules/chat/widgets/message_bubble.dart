import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {super.key,
      required this.imageurl,
      required this.message,
      required this.isme,
      required this.username});
  final String message;
  final bool isme;
  final String username;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment:
                    isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: Theme.of(context)
                            .accentTextTheme
                            .titleLarge
                            ?.color),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: isme ? Colors.green : Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
        Positioned(
            top: -10,
            left: isme ? null : 120,
            right: isme ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageurl),
            )),
      ],
    );
  }
}
