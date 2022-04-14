import 'package:flutter/material.dart';

import 'quizzoptionspage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: TextButton(
          onPressed: (() => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzOptionsPage()))
          }),
          child: const Text("Quizz"),)),
    );
  }
}