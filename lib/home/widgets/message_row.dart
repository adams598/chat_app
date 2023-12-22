import 'package:flutter/material.dart';

import '../../models/message.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: message.user.color,
            child: Text(message.user.userName),
          ),
          const SizedBox(width: 10),
          Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                  color: message.user.color,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Center(child: Text(message.message))
          )
        ],
      ),
    );
  }
}
