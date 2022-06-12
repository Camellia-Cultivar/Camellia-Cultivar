import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/api_service.dart';
import '../model/uploaded_specimen.dart';

import '../navbar/botnavbar.dart';
import 'new_specimen_page.dart';

class UploadedSpecimensPage extends StatefulWidget {
  const UploadedSpecimensPage({Key? key}) : super(key: key);

  @override
  State<UploadedSpecimensPage> createState() => _UploadedSpecimensPage();
}

class _UploadedSpecimensPage extends State<UploadedSpecimensPage> {
  late final Future? requestsFuture;
  final api = APIService();
  @override
  void initState() {
    super.initState();
    requestsFuture = api.getUploadedSpecimens();
  }

  List<Padding> _uploadedRequests(
      BuildContext context, List<UploadedSpecimen> uploadedSpecimens) {
    var screensize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    return List.generate(
        uploadedSpecimens.length,
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
                  SizedBox(
                      height: screensize.height / 4.59,
                      width: screensize.width / 2.18,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                          child: Image.network(uploadedSpecimens[index].photo,
                              fit: BoxFit.fill))),
                  // width: screensize.width / 2.18,
                  // height: screensize.height / 4.6)),
                ]),
                Column(children: [
                  Column(children: [
                    SizedBox(
                        width: screensize.width / 2.035,
                        child: Container(
                          // width: screensize.width / 2.035,
                          decoration: const BoxDecoration(
                              color: Color(0x1F004D40),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25))),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          DateFormat('yyyy-MM-dd').format(
                                              uploadedSpecimens[index]
                                                  .sumbissionDate),
                                          style: const TextStyle(fontSize: 12),
                                        ))
                                      ])),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          uploadedSpecimens[index].location,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ))
                                      ])),
                            ],
                          ),
                        )),
                    if (uploadedSpecimens[index].results.isEmpty)
                      const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("No identification results yet",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    if (uploadedSpecimens[index].results.isNotEmpty)
                      Column(children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Identification results",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Column(
                            children:
                                _getResults(uploadedSpecimens[index].results))
                      ])
                  ])
                ]),
              ]),
            )));
  }

  List<Padding> _getResults(Map<String, int> map) {
    List<Padding> lst = [];

    map.forEach((key, value) {
      lst.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(value.toString().length == 1
                  ? "0" + value.toString() + "%"
                  : value.toString()),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                child: Text(key.toString() + "%"),
              )
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
                    Flexible(
                        child: Text("Uploaded Specimens",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: screenSize.height / 35,
                                fontWeight: FontWeight.w500)))
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
                            Flexible(
                                child: Text(
                              'New Identification Request',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        ))),
                Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height / 27.52,
                        bottom: screenSize.height / 27.52),
                    child: const Divider(
                      thickness: 2,
                    )),
                FutureBuilder(
                  future: requestsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text(
                            snapshot.error.toString(),
                          ),
                        ],
                      );
                    }

                    if (snapshot.hasData) {
                      var uploadedSpecimens =
                          snapshot.data! as List<UploadedSpecimen>;
                      if (uploadedSpecimens.isEmpty) {
                        return const Center(
                          child: Flexible(
                              child: Text(
                            "No identification Requests posted.",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                        );
                      }
                      return _buildRequestsList(context, uploadedSpecimens);
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text('Something went wrong!')],
                    );
                  },
                ),
              ]))),
      bottomNavigationBar: const BotNavbar(pageIndex: 0),
    );
  }

  Widget _buildRequestsList(
      BuildContext context, List<UploadedSpecimen> uploadedSpecimens) {
    Color primaryColor = Theme.of(context).primaryColor;
    var screenSize = MediaQuery.of(context).size;
    return Column(children: _uploadedRequests(context, uploadedSpecimens));
  }
}
