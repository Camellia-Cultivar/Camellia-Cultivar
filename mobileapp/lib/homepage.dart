import 'dart:io';

import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    File? imageFile;

    void _getFromCamera() async {
      PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Color(0xFF064E3B),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF064E3B),
      //   // title: Text("Home Page"),
      // ),
      body: Column(children: [
        Container(
            height: 150,
            color: Color(0xFF064E3B),
            // margin: EdgeInsets.only(left: 50, right: 50),

            // const BorderRadius.all(const Radius.circular(8))),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25, left: 20),
                  child: Center(
                      child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  )),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Center(
                        child: Text(
                      ', Emerald ',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                      // textAlign: TextAlign.center,
                    ))),
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(Icons.account_circle_outlined),
                      color: Colors.white,
                      onPressed: () {},
                    ))
              ],
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            height: 1000,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Color(0x064E3B)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            // margin: const Margin,
            child: Column(
              children: [
                // const Text(
                //   'Recently uploaded Requests',
                //   style: TextStyle(color: Colors.black, fontSize: 18),
                //   textAlign: TextAlign.left,
                // ),
                // const Padding(padding: EdgeInsets.all(10)),
                // CarouselSlider(
                //   options: CarouselOptions(
                //       aspectRatio: 1.5,
                //       viewportFraction: 0.9,
                //       enlargeCenterPage: true,
                //       enlargeStrategy: CenterPageEnlargeStrategy.height),
                //   items: [
                //     Card(
                //       child: Column(
                //         children: [
                //           Container(
                //             decoration: const BoxDecoration(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(15))),
                //             child: Image.network(
                //               'https://www.gardenia.net/storage/app/public/plant_family/detail/57142905_m.jpg',
                //               height: 150,
                //             ),
                //           )
                //         ],
                //       ),
                //       // ListTile(
                //       //   title: Text("Android.com"),
                //       // ),
                //       elevation: 8,
                //       shadowColor: Colors.blueGrey,
                //     ),
                //     Card(
                //       child: Column(
                //         children: [
                //           Container(
                //             decoration: const BoxDecoration(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(15))),
                //             child: Image.network(
                //               'https://www.gardenia.net/storage/app/public/plant_family/detail/57142905_m.jpg',
                //               height: 150,
                //             ),
                //           )
                //         ],
                //       ),
                //       // ListTile(
                //       //   title: Text("Android.com"),
                //       // ),
                //       elevation: 8,
                //       shadowColor: Colors.blueGrey,
                //     ),
                //     Card(
                //       child: Column(
                //         children: [
                //           Container(
                //             decoration: const BoxDecoration(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(15))),
                //             child: Image.network(
                //               'https://www.gardenia.net/storage/app/public/plant_family/detail/57142905_m.jpg',
                //               height: 150,
                //             ),
                //           )
                //         ],
                //       ),
                //       // ListTile(
                //       //   title: Text("Android.com"),
                //       // ),
                //       elevation: 8,
                //       shadowColor: Colors.blueGrey,
                //     ),
                //   ],
                // )
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraPage()));
                    },
                    child: Container(
                        height: 125,
                        decoration: const BoxDecoration(
                            color: Color(0xFF064E3B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                              'New Identification\nRequest',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                        // ListTile(
                        //   title: Text(
                        //     "Codesinsider.com",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        // ),
                        // color: Color(0xFF064E3B),
                        )),
                // const Padding(padding: EdgeInsets.all(20)),
                const Divider(
                  height: 50,
                  color: Colors.grey,
                ),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.only(left: 70)),
                    Center(
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF064E3B),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text('Camellia Map',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF064E3B)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BotNavbar(pageIndex: 1),
    );
  }
}
