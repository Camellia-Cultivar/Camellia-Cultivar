import 'package:camellia_cultivar/api/api_service.dart';
import 'package:camellia_cultivar/model/question.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quiz_options_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormItem {
  int? specimen_id;
  String? answer;

  FormItem(this.specimen_id, this.answer);

  Map<String, dynamic> getData() {
    return {"specimen_id": specimen_id, "answer": answer};
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  var ids = [];
  final api = APIService();

  List<Question> json = [
    Question(specimenId: 22, images: [
      "https://wikiimg.tojsiabtv.com/wikipedia/commons/thumb/e/e9/Camellia_japonica_NBG.jpg/1200px-Camellia_japonica_NBG.jpg"]),
    Question(specimenId: 34, images: [
      "https://www.portaldojardim.com/pdj/wp-content/uploads/Yuletide-1.jpg",
      "https://mosarte.com.au/wp-content/uploads/2019/03/CamelliaSasanquaCROP-HR-scaled.jpg"]),
    Question(specimenId: 60, images: [
      "https://www.awanursery.co.nz/wp-content/uploads/Camellia-sasanqua-Silver-Dollar-April-2018.jpg"
    ]),
    Question(specimenId: 61, images: [
      "https://www.flowerpower.com.au/media/catalog/product/9/3/9319762001561.jpg",
      "https://m.planfor.pt/Donnees_Site/Produit/Images/1650/camelia-do-japao-margaret-davis_PT_500_0019398.jpg"
    ]),
    Question(specimenId: 70, images: [
      "https://2.bp.blogspot.com/-Crmwaof6HG8/U0PZFm8m5BI/AAAAAAAAYEY/xTyVTtlS3Vs/s1600/camelia+black+lace.jpg"
    ]),
    Question(specimenId: 79, images: [
      "https://i.pinimg.com/originals/fe/e1/7c/fee17cec0daf2921c9f488162f901255.jpg"
    ])
  ];

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
    ids = List<int>.generate(json.length, (i) => i);
  }

  void handleNext() {
    setState(() => {
          if (_currentIndex < json.length - 1) {_currentIndex++},
        });
  }

  void handleBack() {
    setState(() => {if (_currentIndex > 0) _currentIndex--});
  }

  void handleEditingComplete() {
    setState(() {
      form[_currentIndex] =
          FormItem(json[_currentIndex].toJson()["specimenId"], _cultivarNameController?.text);
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

    _cultivarNameController?.text = form[_currentIndex]?.answer ?? "";

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
                                        const QuizOptionsPage()))
                          })),
                      icon: const Icon(
                        IconData(0xe16a, fontFamily: 'MaterialIcons'),
                        size: 30,
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: map<Widget>(ids, (index, url) {
                        return Container(
                          width: screenSize.width / 40,
                          height: screenSize.height / 20,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? const Color(0x5F064E3B)
                                : (form[index]?.answer != null
                                    ? primaryColor
                                    : Colors.white),
                            border: Border.all(color: Colors.black),
                          ),
                        );
                      }),
                    ),
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
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      width: screenSize.width / 1.5,
                      height: screenSize.height / 3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: json[_currentIndex].toJson()["images"].length,
                          itemBuilder: (BuildContext context, int position) {
                            List<String>? images =
                                json[_currentIndex].toJson()["images"];
                            return Image.network(images![position],
                                width: screenSize.width / 1.5,
                                fit: BoxFit.fitHeight);
                          }),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 30),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: screenSize.height / 14.5,
                          width: screenSize.width / 3.5,
                          child: TextButton(
                              onPressed: () => handleBack(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: Colors.white))),
                              ),
                              child: Text("Back".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300))),
                        ),
                        SizedBox(
                          height: screenSize.height / 14.5,
                          width: screenSize.width / 3.5,
                          child: TextButton(
                              onPressed: () => handleNext(),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(color: primaryColor))),
                              ),
                              child: Text("Next".toUpperCase(),
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w300))),
                        ),
                      ],
                    ),
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
                            child: Text("Submit Quizz".toUpperCase(),
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
