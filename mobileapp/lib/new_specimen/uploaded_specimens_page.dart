import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/uploaded_specimen.dart';

import '../navbar/botnavbar.dart';
import 'new_specimen_page.dart';

List<UploadedSpecimen> data = [
  UploadedSpecimen(
      date: DateTime.parse('2020-01-02'), location: "Aveiro", results: {}),
  UploadedSpecimen(
      date: DateTime.parse('2020-01-03'),
      location: "Coimbra",
      results: {8: "camellia sasanqua", 70: "camellia japonica"})
];

class UploadedSpecimensPage extends StatefulWidget {
  const UploadedSpecimensPage({Key? key}) : super(key: key);

  @override
  State<UploadedSpecimensPage> createState() => _UploadedSpecimensPage();
}

class _UploadedSpecimensPage extends State<UploadedSpecimensPage> {
  List<Padding> _uploadedRequests(
      int count, Color primaryColor, Size screensize) {
    return List.generate(
        count,
        (index) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: screensize.height / 4.54,
              width: screensize.width / 1.03,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primaryColor),
              ),
              child: Row(children: [
                Column(children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                      child: Image.network(
                          "https://www.divineplantsonline.com.au/products/1112-834.jpg",
                          width: screensize.width / 2.18,
                          height: screensize.height / 4.6)),
                ]),
                Column(children: [
                  Column(children: [
                    Container(
                      width: screensize.width / 2.07,
                      decoration: const BoxDecoration(
                          color: Color(0x1F004D40),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(data[index].date),
                                      style: const TextStyle(fontSize: 12),
                                    ))
                                  ])),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      data[index].location,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ))
                                  ])),
                        ],
                      ),
                    ),
                    if (data[index].results.isEmpty)
                      const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("No identification results yet",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    if (data[index].results.isNotEmpty)
                      Column(children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Identification results",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Column(children: _getResults(data[index].results))
                      ])
                  ])
                ]),
              ]),
            )));
  }

  List<Padding> _getResults(Map<int, String> map) {
    List<Padding> lst = [];

    map.forEach((key, value) {
      lst.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(key.toString().length == 1
                  ? "0" + key.toString() + "%"
                  : key.toString() + "%"),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Text(value)
            ],
          )));
    });

    return lst;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6F7),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Padding(
                    padding: EdgeInsets.only(top: screenSize.height / 13.76)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Uploaded Specimens",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: screenSize.height / 35,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height / 20)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewSpecimenPage()));
                    },
                    child: Container(
                        height: screenSize.height / 6.6,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                            ),
                            Center(
                                child: Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 50,
                            )),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Text(
                              'New Identification Request',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))),
                Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height / 27.52,
                        bottom: screenSize.height / 27.52),
                    child: const Divider(
                      thickness: 2,
                    )),
                Column(
                    children: _uploadedRequests(
                        data.length, primaryColor, screenSize))
              ]))),
      bottomNavigationBar: const BotNavbar(pageIndex: 0),
    );
  }
}
