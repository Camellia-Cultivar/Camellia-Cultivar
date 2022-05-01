import 'package:camellia_cultivar/profilepage.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quizzoptionspage.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   State<EditProfilePage> createState() => _EditProfilePage();
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Center(
            child: Column(children: [
          TextButton(
              onPressed: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizzOptionsPage()))
                  }),
              child: const Text("Quizz")),
          TextButton(
              onPressed: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()))
                  }),
              child: const Text("Profile")),
        ])));
  }
}
