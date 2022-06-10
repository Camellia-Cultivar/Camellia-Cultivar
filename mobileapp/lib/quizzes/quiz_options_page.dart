import 'dart:html';

import 'package:camellia_cultivar/model/question.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quizzes/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../navbar/botnavbar.dart';

class QuizOptionsPage extends StatelessWidget {
  const QuizOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    User? user = context.watch<UserProvider>().user;

    final api = APIService();
    List<Question>? questions;

    List<String> rules = [
      "You will be asked to identify the cultivars of the different specimens that will be shown.",
      "It's possible to skip some specimen identifications, in case you don't know them.",
      "Please make sure to press enter on your keyboard to save your answers."
    ];

    _handleStartNewQuiz(BuildContext context) async {
      questions = await api.getQuiz(user!);
      if (questions == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "No quizzes are available, come back later!",
                style: TextStyle(color: Colors.blue),
              )),
        );
        return;
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => QuizPage(questions!)));
    }

    return Scaffold(
      backgroundColor: const Color(0XFFF6F6F7),
      body: Center(
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0x0F064E3B),
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.fromLTRB(
                  screenSize.width / 15.7,
                  screenSize.height / 20.6,
                  screenSize.width / 15.7,
                  screenSize.height / 20.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Quizzes",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenSize.height / 35,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(45, 6, 78, 59),
                          borderRadius: BorderRadius.circular(15.0)),
                      margin: EdgeInsets.fromLTRB(
                          screenSize.width / 15,
                          screenSize.width / 30,
                          screenSize.width / 15,
                          screenSize.width / 30),
                      padding: EdgeInsets.fromLTRB(
                          screenSize.width / 15,
                          screenSize.width / 80,
                          screenSize.width / 15,
                          screenSize.width / 80),
                      child: Column(
                        children: [
                          const Text(
                            "The rules",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Padding(padding: EdgeInsets.all(6)),
                          for (int i = 0; i < rules.length; i++)
                            _buildRule(rules[i], i + 1),
                        ],
                      )),
                  SizedBox(
                    height: screenSize.height / 12.5,
                    width: screenSize.width / 1.8,
                    child: TextButton(
                        onPressed: () => {_handleStartNewQuiz(context)},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.white))),
                        ),
                        child: Text("Start New Quiz".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300))),
                  ),
                ],
              ))),
      bottomNavigationBar: const BotNavbar(pageIndex: 2),
    );
  }

  Widget _buildRule(String rule, int ruleNum) {
    return Column(
      children: [
        Row(children: [
          Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF064E3B),
                  ),
                  color: const Color(0xFF064E3B),
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: Center(
                child: Text(
                  ruleNum.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )),
          Padding(padding: EdgeInsets.all(10)),

          Flexible(child: Text(rule)),
          // const Text(
          //     "You will be asked to identify the cultivar of the different specimens that will be shown."))
        ]),
        Padding(padding: EdgeInsets.all(5))
      ],
    );
  }
}

// Widget _buildPopupDialog(BuildContext context) {
//   return AlertDialog(
//     title: const Text('Insert Quizz Code:'),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const <Widget>[
//         TextField(
//           decoration: InputDecoration(
//             hintText: "Code",
//             hintStyle: TextStyle(fontSize: 14),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: primaryColor),
//             ),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: primaryColor),
//             ),
//           ),
//         )
//       ],
//     ),
//     actions: <Widget>[
//       TextButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         child: const Text("Close", style: TextStyle(color: primaryColor)),
//       ),
//       TextButton(
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const QuizzPage()));
//         },
//         child: const Text('Start Quizz',
//             style: TextStyle(color: primaryColor)),
//       ),
//     ],
//   );
// }
