import 'dart:convert';
import 'dart:io';

import 'package:chat_app/home/widgets/input_row.dart';
import 'package:chat_app/home/widgets/message_row.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Message> _messages = [];
  User user1 = User("1", Colors.yellow, "Jean-Michel");
  User user2 = User("2", Colors.blue, "B");

  Future<void> saveData(User newUser) async {
    final SharedPreferences prefs = await _prefs;
    final newUserEncoded = jsonEncode(newUser.toJson());
    print(newUserEncoded);
    await prefs.setString(newUser.id, newUserEncoded);
    print("User saved");
  }

  Future<User?> getUser(String id) async {
    final SharedPreferences prefs = await _prefs;
    final userEncoded = prefs.getString(id);
    if(userEncoded != null) {
      final userDecoded = jsonDecode(userEncoded);
      print(userDecoded);
      final user = User.fromJson(userDecoded);
      return user;
    }else{
      throw Exception();
    }

  }
  Future<void> getAllUsers() async {
    try{
      user1 = (await getUser(user1.id))!;
      user2 = (await getUser(user2.id))!;
    }catch (e){
      print("Le user n'a jamais été sauvegardé");
    }
  }

  @override
  void initState() {
    getUser("1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Talk to myself"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                  itemBuilder: (context, index){
                    return MessageRow(message: _messages[index]);
              }),
            ),
            const Spacer(),
            InputRow(user: user1, onPressed: (newText) {
              setState(() {
                final newMessage = Message(newText, user1);
                _messages.add(newMessage);
              });
            },
              onTap: (newUser) async {
              await saveData(newUser);
                setState(() {
                    user1 = newUser;
                });
              },
            ),
            InputRow(
              user: user2, onPressed: (newText) {
                setState(() {
                  final newMessage = Message(newText, user2);
                  _messages.add(newMessage);
                });
              },
              onTap: (newUser) async {
                await saveData(newUser);
                setState(() {
                    user2 = newUser;
                });
              },
            )

          ],
        ),
      ),
    );
  }
}
