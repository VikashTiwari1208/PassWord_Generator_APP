import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Myapp(),
    debugShowCheckedModeBanner: false,
  ));
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final inputController = TextEditingController();
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Generator"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Random Password Generator",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: inputController,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      final data = ClipboardData(text: inputController.text);
                      Clipboard.setData(data);
                      final snackbar = SnackBar(
                        content: Text(
                          "Text Copied To ClipBoard",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.pink,
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackbar);
                    },
                  )),
            ),
            const SizedBox(height: 12),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final bgcolor = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed) ? Colors.pink : Colors.black);
    return ElevatedButton(
        onPressed: () {
          final password = Password_Generator();
          inputController.text = password;
        },
        style: ButtonStyle(backgroundColor: bgcolor),
        child: Text("ClickToGenerate"));
  }
}

// ignore: non_constant_identifier_names
String Password_Generator(
    {bool hasLetter = true, bool hasNumber = true, bool hasCharacters = true}) {
  final lengthOfPassword = 13;
  final String smallLetters = "abcdefghijklmnoprstuvwxyz";
  final String capsLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String numebrs = "0123456789";
  final String symbols = "@!+=*&%?(){}";
  String char = "";
  if (hasLetter) {
    char += "$smallLetters";
    char += "$capsLetters";
  }
  if (hasNumber) {
    char += "$numebrs";
  }
  if (hasCharacters) {
    char += "$symbols";
  }
  return List<String>.generate(lengthOfPassword, (index) {
    final int idx = Random().nextInt(char.length);
    return char[idx];
  }).join("");
}
