import 'package:chat_app/home/home_page.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.selectedUser});
  final User selectedUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> userNames = ["A", "B", "C", "D", "Jean-Michel", "ADAMS"];
  late String firstItem ;
  bool light = false;


  @override
  void initState() {
    light = widget.selectedUser.color == Colors.yellow ? true : false;
    firstItem = widget.selectedUser.userName;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon profil"),
      ),
      body: Column(
        children: [
          Row(
              children: [
                const Text("Changement de couleur "),
                const SizedBox(width: 8,),
                Container(
                  height: 50,
                  width: 50,
                  color: light ? Colors.yellow : Colors.blue,
                  child: Text(""),
                ),
                const SizedBox(width: 4,),
                Switch(
                  // This bool value toggles the switch.
                  value: light,
                  activeColor: Colors.yellow,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      light = value;
                    });
                  },
                )
              ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Text("Changement de nom "),
              const SizedBox(height: 8,),
              DropdownButton<String>(
                value: firstItem,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {

                  setState(() {
                    firstItem = value!;
                  });
                },
                items: userNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          ElevatedButton(onPressed: (){
            final newColor = light ? Colors.yellow : Colors.blue;
            final newUser = User( widget.selectedUser.id,newColor, firstItem);
            Navigator.of(context).pop(newUser); // prendre le context actuel et revenir un cran en arrière
          }, child: Text("Save"))

        ],
      ),
    );
  }
}
