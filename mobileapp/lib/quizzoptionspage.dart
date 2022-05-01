import 'package:camellia_cultivar/quizzpage.dart';
import 'package:flutter/material.dart';

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
                ],
              ))),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Insert Quizz Code:'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: "Code",
            hintStyle: TextStyle(fontSize: 14),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF064E3B)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF064E3B)),
            ),
          ),
        )
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Close", style: TextStyle(color: Color(0xFF064E3B))),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QuizzPage()));
        },
        child: const Text('Start Quizz',
            style: TextStyle(color: Color(0xFF064E3B))),
      ),
    ],
  );
}
