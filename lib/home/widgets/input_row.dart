import 'package:chat_app/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../../models/User.dart';

class InputRow extends StatefulWidget {

  const InputRow({super.key, required this.onPressed, required this.user, required this.onTap});
  final User user;
  final Function(String) onPressed;
  final Function(User) onTap;

  @override
  State<InputRow> createState() => _InputRowState();
}

class _InputRowState extends State<InputRow> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async{
            final newUser = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage(selectedUser: widget.user,)));
            widget.onTap(newUser);
          },
          child: CircleAvatar(
            backgroundColor: widget.user.color,
            child: Text(widget.user.userName),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        widget.onPressed(_controller.text);
                          _controller.clear();
                      }, icon: const Icon(Icons.send)),
                  border: const OutlineInputBorder(),
                  labelText: 'Message'
              ),
            ),
          ),
        )
      ],
    );
  }
}
