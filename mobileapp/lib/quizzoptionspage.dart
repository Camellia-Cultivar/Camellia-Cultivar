import 'package:camellia_cultivar/bluetooth.dart';
import 'package:camellia_cultivar/quizzpage.dart';
import 'package:flutter/material.dart';

import 'navbar/botnavbar.dart';

class QuizzOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF6F6F7),
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0x0F064E3B),
                  borderRadius: BorderRadius.circular(15.0)),
              height: 600,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Quizzes",
                      style: TextStyle(color: Color(0xFF064E3B), fontSize: 30)),
                  SizedBox(
                    height: 69,
                    width: 260,
                    child: TextButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizzPage()))
                            },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF064E3B)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.white))),
                        ),
                        child: Text("Start New Quizz".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
                                      builder: (context) => FlutterBlueApp()))
                            },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF064E3B)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.white))),
                        ),
                        child: Text("Share with friends".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300))),
                  ),
                ],
              ))),
      bottomNavigationBar: const BotNavbar(pageIndex: 2),
    );
  }
}
