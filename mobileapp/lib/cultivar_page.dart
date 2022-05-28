import 'package:camellia_cultivar/home/image_full_slider_map.dart';
import 'package:flutter/material.dart';

import 'api/api_service.dart';

Map<String, dynamic> json = {
  "cultivar_name": "Yuletide",
  "species": "Camellia Sasanqua",
  "scientific_name": "Camellia Sasanqua Yuletide",
  "main_photo":
      "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/pink-camellia-flower-blooming-in-early-spring-dave-hansche.jpg",
  "details": "",
  "photos": [
    "https://cdn.shopify.com/s/files/1/0012/9689/2016/products/Jacks2_300x300.jpg?v=1646599582",
    "https://cdn.shopify.com/s/files/1/0012/9689/2016/products/Jacks2_300x300.jpg?v=1646599582"
  ]
};

class CultivarPage extends StatefulWidget {
  const CultivarPage({Key? key}) : super(key: key);

  @override
  State<CultivarPage> createState() => _CultivarPage();
}

class _CultivarPage extends State<CultivarPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFFF),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: screenSize.height / 13.75)),
                  Padding(
                      padding: EdgeInsets.only(right: screenSize.width / 4.36),
                      child: Wrap(
                        spacing: 50,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          BackButton(
                            color: primaryColor,
                          ),
                          Text(json["cultivar_name"],
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: screenSize.height / 35,
                                  fontWeight: FontWeight.w500))
                        ],
                      )),
                  const Padding(padding: EdgeInsets.all(20)),
                  SizedBox(
                      width: screenSize.width / 1.5,
                      height: screenSize.height / 3,
                      child: Image.network(json["main_photo"],
                          width: screenSize.width / 1.5,
                          fit: BoxFit.fitHeight)),
                  const Padding(padding: EdgeInsets.all(20)),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        width: screenSize.width / 2.3,
                        height: screenSize.height / 16.5,
                        left: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(150)),
                          child: const Text(
                            "Species/Combination",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: screenSize.width / 1.22,
                          height: screenSize.height / 16.5,
                          decoration: BoxDecoration(
                              color: const Color(0X1F064E3B),
                              borderRadius: BorderRadius.circular(150)),
                          child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                json["species"],
                                style: TextStyle(color: primaryColor),
                              ))),
                    ],
                    clipBehavior: Clip.none,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        width: screenSize.width / 2.3,
                        height: screenSize.height / 16.5,
                        left: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(150)),
                          child: const Text(
                            "Scientific Name",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: screenSize.width / 1.22,
                          height: screenSize.height / 16.5,
                          decoration: BoxDecoration(
                              color: const Color(0X1F064E3B),
                              borderRadius: BorderRadius.circular(150)),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width / 2.62, right: 20),
                              child: Text(
                                json["scientific_name"],
                                style: TextStyle(color: primaryColor),
                                textAlign: TextAlign.end,
                              ))),
                    ],
                    clipBehavior: Clip.none,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: 20, left: 20, top: screenSize.height / 30),
                      child: ExpansionTile(
                        collapsedIconColor: primaryColor,
                        collapsedTextColor: primaryColor,
                        title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.add_circle,
                                color: primaryColor, size: 40),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text("More Details",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: screenSize.height / 45))
                          ],
                        ),
                        //TODO: Set what comes from API
                        children: <Widget>[Text("")],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: SizedBox(
                        width: screenSize.width / 1.23,
                        child: TextButton(
                            style: const ButtonStyle(
                                alignment: Alignment.centerLeft),
                            onPressed: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SliderShowFullmages(
                                          listImagesModel: json["photos"],
                                          current: 0)))
                                },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.photo_library,
                                    color: primaryColor, size: 40),
                                const Padding(padding: EdgeInsets.all(10)),
                                Text("More Photos",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: screenSize.height / 45,
                                        fontWeight: FontWeight.normal))
                              ],
                            ))),
                  ),
                ],
              ),
            )));
  }
}
