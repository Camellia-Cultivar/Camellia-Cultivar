import 'package:camellia_cultivar/cultivar_page.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import 'image_full_slider_map.dart';

class SpecimenPopup extends StatefulWidget {
  final Map<String, dynamic>? specimen;

  const SpecimenPopup({Key? key, this.specimen}) : super(key: key);

  @override
  SpecimenPopupState createState() => SpecimenPopupState();
}

class SpecimenPopupState extends State<SpecimenPopup> {
  // var photos = [
  //   "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
  //   "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000",
  //   "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80"
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return _buildDialogContent();
  }

  final api = APIService();
  Map<String, dynamic> cultivarDetails = {};

  getCultivarDetails(int cultivarId) async {
    var cultivar = await api.getCultivar(cultivarId);
    setState(() {
      cultivarDetails = cultivar;
    });
  }

  Container _buildDialogContent() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: 200,
      height: 250,
      child: Column(
        children: <Widget>[
          Expanded(child: _buildImagesContainer()),
          Expanded(
            child: Column(
              children: <Widget>[
                _buildCultivarName(),
                _buildSpeciesName(),
                _buildViewCultivarDetailsBtn()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImagesContainer() {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: expandForMoreImages(widget.specimen!["photos"]));
  }

  Container _buildCultivarName() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.specimen!["epithet"],
          style: TextStyle(fontSize: 20),
        )
      ]),
    );
  }

  Container _buildSpeciesName() {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.specimen!["species"],
          style: TextStyle(fontSize: 12),
        )
      ]),
    );
  }

  MaterialButton _buildViewCultivarDetailsBtn() {
    return MaterialButton(
      color: const Color(0xFF064E3B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: () async => {
        await getCultivarDetails(widget.specimen!["cultivar_id"]),
        if (cultivarDetails.isEmpty)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      "Couldn't access the specimen, please try again later."),
                  backgroundColor: Colors.red),
            ),
          }
        else
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CultivarPage(cultivarDetails: cultivarDetails)))
          }
      },
      child: const Text(
        "Cultivar Details",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget expandForMoreImages(List list) {
    var idx = 0;
    if (list.isEmpty) {
      return SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text("No images to show"),
        ),
      );
    }
    var obj = ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SliderShowFullmages(
                      listImagesModel: list,
                      current: idx,
                      isNetworkImg: true,
                    )));
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
