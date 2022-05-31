import 'package:camellia_cultivar/api/api_service.dart';
import 'package:camellia_cultivar/home/homepage.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quiz_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UniqueQuizPage extends StatefulWidget {
  final int? specimenId;

  final String image;

  const UniqueQuizPage({Key? key, required this.specimenId, required this.image}) : super(key: key);

  @override
  _UniqueQuizPageState createState() => _UniqueQuizPageState();
}

class _UniqueQuizPageState extends State<UniqueQuizPage> {
  final api = APIService();


  List<String> lst = <String>[
    'C. Japonica April Dawn',
    'C. Japonica Debutante',
    'C. Sasanqua Mine No Uki',
  ];



  List<T> map<T>(List data, Function handler) {
    List<T> result = [];
    for (var i = 0; i < data.length; i++) {
      result.add(handler(i, data[i]));
    }
    return result;
  }

  Map<int, FormItem> form = {};

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
  }

  void handleEditingComplete() {
    setState(() {
      form[widget.specimenId!] =
          FormItem(widget.specimenId, _cultivarNameController?.text);
    });
    _focusInput?.unfocus();
  }

  void handleSubmit(User? user) async {
    if (user == null) {
      return;
    }

    List<FormItem> answers = form.values.toList();
    answers.removeWhere((item) => item.answer == null || item.answer!.isEmpty);

    await api.setQuizAnswers(user.id, answers);

    //int? reputation = await api.setQuizAnswers(user.id, answers);

    // if(reputation != null) {
    //   user.reputation = reputation;
    // }

    //context.read<UserProvider>().setUser(user);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
              'Thank you for answering this quiz!'),
          backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    var screenSize = MediaQuery.of(context).size;

    User? user = context.read<UserProvider>().user;

    _cultivarNameController?.text = form[widget.specimenId]?.answer ?? "";

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
                                    builder: (context) =>
                                        const HomePage()))
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
                      child: Image.network(widget.image,
                                width: screenSize.width / 1.5,
                                fit: BoxFit.fitHeight)
                    ),
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
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }
                            return lst.where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: screenSize.height / 12.5,
                        width: screenSize.width / 1.8,
                        child: TextButton(
                            onPressed: () => handleSubmit(user),
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
}
