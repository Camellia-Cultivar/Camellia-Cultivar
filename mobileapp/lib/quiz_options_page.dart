import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'navbar/botnavbar.dart';

class QuizOptionsPage extends StatelessWidget {
  const QuizOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    User? user = context.watch<UserProvider>().user;

    final api = APIService();

    _handleStartNewQuiz() async {
      api.getQuiz(user!);
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
                  SizedBox(
                    height: screenSize.height / 12.5,
                    width: screenSize.width / 1.8,
                    child: TextButton(
                        onPressed: () => {
                              //load quizz
                              _handleStartNewQuiz()
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const QuizPage()))
                            },
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
