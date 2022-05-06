import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quizzoptionspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camellia_cultivar/database/database_helper.dart';

import 'navbar/botnavbar.dart';

class FormItem {
  int? specimen_id;
  String? answer;

  FormItem(this.specimen_id, this.answer);

  Map? getData() {
    return {"specimen_id": specimen_id, "answer": answer};
  }
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  int _currentIndex = 0;
  var data = [];
  var ids = [];

  Map<int, List<String>> json = {
    22: [
      "https://wikiimg.tojsiabtv.com/wikipedia/commons/thumb/e/e9/Camellia_japonica_NBG.jpg/1200px-Camellia_japonica_NBG.jpg"
    ],
    34: [
      "https://www.portaldojardim.com/pdj/wp-content/uploads/Yuletide-1.jpg",
      "https://mosarte.com.au/wp-content/uploads/2019/03/CamelliaSasanquaCROP-HR-scaled.jpg"
    ],
    60: [
      "https://www.awanursery.co.nz/wp-content/uploads/Camellia-sasanqua-Silver-Dollar-April-2018.jpg"
    ],
    61: [
      "https://www.flowerpower.com.au/media/catalog/product/9/3/9319762001561.jpg",
      "https://m.planfor.pt/Donnees_Site/Produit/Images/1650/camelia-do-japao-margaret-davis_PT_500_0019398.jpg"
    ],
    70: [
      "https://2.bp.blogspot.com/-Crmwaof6HG8/U0PZFm8m5BI/AAAAAAAAYEY/xTyVTtlS3Vs/s1600/camelia+black+lace.jpg"
    ],
    79: [
      "https://i.pinimg.com/originals/fe/e1/7c/fee17cec0daf2921c9f488162f901255.jpg"
    ],
  };

  List<T> map<T>(List data, Function handler) {
    List<T> result = [];
    for (var i = 0; i < data.length; i++) {
      result.add(handler(i, data[i]));
    }
    return result;
  }

  Map<int, FormItem> form = {};

  final cultivarNameController = TextEditingController();
  final FocusNode focusInput = FocusNode();

  @override
  void dispose() {
    cultivarNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    json.forEach((key, value) => data.add({"key": key, "images": value}));
    ids = List<int>.generate(data.length, (i) => i);
  }

  void handleNext() {
    setState(() => {
          if (_currentIndex < data.length - 1) {_currentIndex++},
        });
  }

  void handleBack() {
    setState(() => {if (_currentIndex > 0) _currentIndex--});
  }

  void handleEditingComplete() {
    setState(() {
      form[_currentIndex] =
          FormItem(data[_currentIndex]["key"], cultivarNameController.text);
    });
    focusInput.unfocus();
  }

  void handleSubmit(User? user) async {
    if (user == null) {
      return;
    }

    List<FormItem> answers = form.values.toList();
    answers.removeWhere((item) => item.answer == null || item.answer!.isEmpty);
    int reputation = answers.length;

    user.reputation += reputation;

    final dbHelper = DatabaseHelper.instance;
    await dbHelper.update("users", user.toMap());
    context.read<UserProvider>().setUser(user);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Congratulations! You have received +$reputation reputation.'),
          backgroundColor: Colors.green),
    );

    // form.entries.forEach((entry) =>
    // answers.add(entry.value.getData())),
    // responses[user!.id] = answers,
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    var screenSize = MediaQuery.of(context).size;

    User? user = context.read<UserProvider>().user;

    cultivarNameController.text = form[_currentIndex]?.answer ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            height: screenSize.height / 1.2,
            width: screenSize.width / 1.2,
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
                                    builder: (context) => QuizzOptionsPage()))
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
                          // width: 10.0,
                          // height: 60.0,
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
                    SizedBox(
                      width: screenSize.width / 1.5,
                      height: screenSize.height / 3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data[_currentIndex]["images"].length,
                          itemBuilder: (BuildContext context, int position) {
                            List<String>? images =
                                data[_currentIndex]["images"];
                            return Image.network(images![position],
                                width: screenSize.width / 1.5,
                                fit: BoxFit.fitHeight);
                          }),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 30),
                        width: screenSize.width / 1.5,
                        child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Name',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                            controller: cultivarNameController,
                            focusNode: focusInput,
                            onEditingComplete: () => handleEditingComplete())),
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
            )),
      ),
      bottomNavigationBar: const BotNavbar(pageIndex: 2),
    );
  }
}
