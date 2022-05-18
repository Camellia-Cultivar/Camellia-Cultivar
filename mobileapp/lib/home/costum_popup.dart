import 'package:flutter/material.dart';

import 'image_full_slider_map.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup({Key? key}) : super(key: key);

  @override
  CustomPopupState createState() => CustomPopupState();
}

class CustomPopupState extends State<CustomPopup> {
  final list = [
    "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
    "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000",
    "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80"
  ];

  final _current = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }

  Container _buildDialogContent() {
    return Container(
      // padding: EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),

      width: 200,
      height: 250,
      child: Column(
        children: <Widget>[
          _buildImagesContainer(),
          Column(
            children: <Widget>[
              _buildCultivarName(),
              _buildSpeciesName(),
              _buildViewCultivarDetailsBtn()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagesContainer() {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: expandForMoreImages(list));
  }

  Container _buildCultivarName() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "Angelina Vieira",
          style: TextStyle(fontSize: 22),
        )
      ]),
    );
  }

  Container _buildSpeciesName() {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "C. Japonica",
          style: TextStyle(fontSize: 15),
        )
      ]),
    );
  }

  MaterialButton _buildViewCultivarDetailsBtn() {
    return MaterialButton(
      color: const Color(0xFF064E3B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: () => {},
      child: const Text(
        "Cultivar Details",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  ClipRRect expandForMoreImages(List list) {
    var idx = 0;
    var obj = ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SliderShowFullmages(listImagesModel: list, current: idx)));
          },
          child: Image.network(
            list[0],
            fit: BoxFit.fitWidth,
            height: 120,
            width: MediaQuery.of(context).size.width,
          ),
        ));
    return obj;
  }
}
