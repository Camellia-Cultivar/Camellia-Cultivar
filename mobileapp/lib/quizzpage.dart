import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quizzoptionspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  List answers = [];

  Map<int, List> responses = {};

  final cultivarNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserProvider>().user;

    if (form[_currentIndex]?.answer != null) {
      cultivarNameController.text = form[_currentIndex]?.answer as String;
    }

    return Scaffold(
        backgroundColor: const Color(0xFFF5F6F7),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              height: 770,
              width: 370,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 30)),
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
                      ),
                      const Padding(padding: EdgeInsets.only(left: 90)),
                      Row(
                        children: map<Widget>(ids, (index, url) {
                          return Container(
                            width: 10.0,
                            height: 60.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? const Color(0x5F064E3B)
                                  : (form[index]?.answer != null
                                      ? const Color(0xFF064E3B)
                                      : Colors.white),
                              border: Border.all(color: Colors.black),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Name the cultivar",
                          style: TextStyle(
                              color: Color(0xFF064E3B), fontSize: 30)),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data[_currentIndex]["images"].length,
                            itemBuilder: (BuildContext context, int position) {
                              List<String>? images =
                                  data[_currentIndex]["images"];
                              return Image.network(images![position],
                                  width: 300, fit: BoxFit.fitHeight);
                            }),
                      ),
                      Container(
                          padding: const EdgeInsets.only(bottom: 40),
                          width: 220,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF064E3B)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF064E3B)),
                              ),
                            ),
                            controller: cultivarNameController,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 120,
                            child: TextButton(
                                onPressed: () => {
                                      setState(() => {
                                            if (_currentIndex > 0)
                                              _currentIndex--
                                          })
                                    },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF064E3B)),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300))),
                          ),
                          SizedBox(
                            height: 60,
                            width: 120,
                            child: TextButton(
                                onPressed: () => {
                                      setState(() => {
                                            if (cultivarNameController
                                                .text.isNotEmpty)
                                              {
                                                form[_currentIndex] = FormItem(
                                                    data[_currentIndex]["key"],
                                                    cultivarNameController
                                                        .text),
                                              },
                                            if (_currentIndex < data.length - 1)
                                              {_currentIndex++},
                                            cultivarNameController.clear()
                                          }),
                                      3
                                    },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                              color: Color(0xFF064E3B)))),
                                ),
                                child: Text("Next".toUpperCase(),
                                    style: const TextStyle(
                                        color: Color(0xFF064E3B),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300))),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          height: 69,
                          width: 260,
                          child: TextButton(
                              onPressed: () => {
                                    form.entries.forEach((entry) =>
                                        answers.add(entry.value.getData())),
                                    responses[user!.id] = answers,
                                  },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF064E3B)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: Colors.white))),
                              ),
                              child: Text("Submit Quizz".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300))),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}
