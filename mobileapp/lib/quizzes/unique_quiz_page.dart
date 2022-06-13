import 'package:camellia_cultivar/api/api_service.dart';
import 'package:camellia_cultivar/home/homepage.dart';
import 'package:camellia_cultivar/quizzes/quiz_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/question.dart';

class UniqueQuizPage extends StatefulWidget {
  final Question question;

  const UniqueQuizPage({Key? key, required this.question}) : super(key: key);

  @override
  _UniqueQuizPageState createState() => _UniqueQuizPageState();
}

class _UniqueQuizPageState extends State<UniqueQuizPage> {
  final api = APIService();

  List<String> optionsList = [];

  List<T> map<T>(List data, Function handler) {
    List<T> result = [];
    for (var i = 0; i < data.length; i++) {
      result.add(handler(i, data[i]));
    }
    return result;
  }

  Map<int, FormItem> form = {};
  Map<String, int> autocompleteOptions = {};

  TextEditingController? _cultivarNameController;
  FocusNode? _focusInput;

  @override
  void dispose() {
    //_cultivarNameController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cultivarNameController?.text =
        form[widget.question.specimenId]?.answer ?? "";
  }

  void handleEditingComplete() {
    String answer = _cultivarNameController!.text;
    setState(() {
      form[widget.question.specimenId] = FormItem(widget.question.specimenId,
          answer, autocompleteOptions[answer.trim()]);
    });
    _focusInput?.unfocus();
  }

  void handleSubmit() async {
    List<FormItem> answers = form.values.toList();
    answers.removeWhere((item) =>
        item.answer == null ||
        item.answer!.isEmpty ||
        item.cultivar_id == null);

    await api.setQuizAnswers(answers);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Thank you for answering this quiz!'),
          backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            height: screenSize.height / 1.2,
            width: screenSize.width / 1.2,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: ((() => {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()))
                          })),
                      icon: const Icon(
                        IconData(0xe16a, fontFamily: 'MaterialIcons'),
                        size: 30,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name the cultivar",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: screenSize.height / 35)),
                    const Padding(padding: EdgeInsets.all(30)),
                    SizedBox(
                        width: screenSize.width / 1.5,
                        height: screenSize.height / 3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.question.toJson()["images"].length,
                          itemBuilder: (BuildContext context, int position) {
                            return Image.network(
                                widget.question.images[position],
                                width: screenSize.width / 1.5,
                                fit: BoxFit.fitHeight);
                          },
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        width: screenSize.width / 1.5,
                        child: Autocomplete<String>(
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            _cultivarNameController =
                                fieldTextEditingController;
                            _focusInput = fieldFocusNode;

                            return TextField(
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              onEditingComplete: handleEditingComplete,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }
                            await getAutocomplete(textEditingValue.text);
                            return optionsList;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: screenSize.height / 12.5,
                        width: screenSize.width / 1.8,
                        child: TextButton(
                            onPressed: () => handleSubmit(),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(
                                          color: Colors.white))),
                            ),
                            child: Text("Submit Quiz".toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300))),
                      ),
                    )
                  ],
                )
              ],
            ))),
      ),
    );
  }

  Future<void> getAutocomplete(String input) async {
    var options = await api.getAutocomplete(input);
    setState(() {
      autocompleteOptions = options;
      optionsList =
          autocompleteOptions.keys.map((denomination) => denomination).toList();
    });
  }
}
