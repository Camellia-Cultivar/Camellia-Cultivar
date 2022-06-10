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
  final Map<String, dynamic> cultivarDetails;

  const CultivarPage({Key? key, required this.cultivarDetails})
      : super(key: key);

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
                          Text(widget.cultivarDetails["epithet"],
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
                      child: widget.cultivarDetails["photograph"] != null
                          ? Image.network(widget.cultivarDetails["photograph"],
                              width: screenSize.width / 1.5,
                              fit: BoxFit.fitHeight)
                          : const Center(
                              child: Text("No images to show"),
                            )),
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
                                widget.cultivarDetails["species"],
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
                                widget.cultivarDetails["epithet"],
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
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(6, 0, 0, 0),
                                borderRadius: BorderRadius.circular(15.0)),
                            margin: EdgeInsets.fromLTRB(
                                screenSize.width / 15,
                                screenSize.width / 30,
                                screenSize.width / 15,
                                screenSize.width / 100),
                            padding: EdgeInsets.fromLTRB(
                                screenSize.width / 15,
                                screenSize.width / 100,
                                screenSize.width / 15,
                                screenSize.width / 80),
                            child: Column(children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.height / 200)),
                              Text("    " +
                                  widget.cultivarDetails["description"]),
                            ]),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(6, 0, 0, 0),
                                borderRadius: BorderRadius.circular(15.0)),
                            margin: EdgeInsets.fromLTRB(
                                screenSize.width / 15,
                                screenSize.width / 30,
                                screenSize.width / 15,
                                screenSize.width / 30),
                            padding: EdgeInsets.fromLTRB(
                                screenSize.width / 15,
                                screenSize.width / 80,
                                screenSize.width / 15,
                                screenSize.width / 80),
                            child: Column(
                              children: [
                                const Text(
                                  "Characteristics",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        screenSize.height / 200)),
                                for (dynamic category in widget
                                    .cultivarDetails["characteristicValues"])
                                  ExpansionTile(
                                    collapsedIconColor: primaryColor,
                                    collapsedTextColor: primaryColor,
                                    title: Text(category["category"] as String),
                                    children: [
                                      for (dynamic subcat
                                          in category["subcategories"])
                                        ListTile(
                                          leading: Text(subcat["subcat"]),
                                          trailing: Text(
                                            subcat["option"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                    ],
                                  )
                              ],
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: SizedBox(
                        width: screenSize.width / 1.23,
                        child: TextButton(
                            style: const ButtonStyle(
                                alignment: Alignment.centerLeft),
                            onPressed: () => handleMorePhotos(context),
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

  handleMorePhotos(BuildContext context) async {
    List<String> photos =
        await APIService().getCultivarPhotos(widget.cultivarDetails["id"]);
    print(photos);
    if (photos.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SliderShowFullmages(
              listImagesModel: photos, current: 0, isNetworkImg: true)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "There aren't more photos.",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white));
    }
  }
}
