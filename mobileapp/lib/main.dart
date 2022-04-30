import 'dart:io';

import 'package:camellia_cultivar/homepage.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camellia Cultivar',
      theme: ThemeData(
        // primarySwatch: Colors.blueGrey,
        primaryColor: Color(0xFF064E3B),
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var login = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffA4A4A4),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              height: 600,
              width: 300,
              // Column with all content
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 60, bottom: 30),
                            width: 220,
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF064E3B)),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF064E3B)),
                                ),
                              ),
                              controller: emailController,
                            )),
                        SizedBox(
                            width: 220,
                            child: TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF064E3B)),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF064E3B)),
                                ),
                              ),
                              controller: passwordController,
                            )),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      height: 69,
                      width: 260,
                      child: TextButton(
                          onPressed: () => {
                                login["email"] = emailController.text,
                                login["password"] = passwordController.text,
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()))
                              },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF064E3B)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(150.0),
                                      side: const BorderSide(
                                          color: Colors.white)))),
                          child: Text("Login".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300))),
                    ),
                    SizedBox(
                      height: 69,
                      width: 260,
                      child: TextButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage())),
                              },
                          style: ButtonStyle(
                              //backgroundColor: MaterialStateProperty.all(Color()),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(150.0),
                                      side: const BorderSide(
                                          color: Color(0xFF064E3B))))),
                          child: Text("Register".toUpperCase(),
                              style: TextStyle(
                                  color: Color(0xFF064E3B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300))),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      TextButton(
                          onPressed: () async {
                            final isAuthenticated =
                                await LocalAuthApi.authenticate();

                            if (isAuthenticated) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          },
                          child: Text("Authenticate with Fingerprint",
                              style: TextStyle(
                                  color: Color(0xFF064E3B), fontSize: 15))),
                      Icon(Icons.arrow_forward,
                          color: Color(0xFF064E3B), size: 20)
                    ])
                  ]),
            ),
            Positioned(
              top: -68,
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF064E3B),
                ),
                height: 136,
                width: 136,
                child:
                    Icon(Icons.person_outlined, color: Colors.white, size: 80),
              ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ),
    );
  }
}
