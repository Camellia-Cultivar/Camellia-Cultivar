import 'dart:convert';

import 'package:camellia_cultivar/home/map_page.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:camellia_cultivar/profile/profile_page.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/quizzes/unique_quiz_page.dart';
import 'package:camellia_cultivar/utils/auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';

import '../api/api_service.dart';
import '../model/question.dart';
import '../new_specimen/new_specimen_page.dart';
import 'specimen_popup.dart';

List<Map<String, dynamic>> recentlyUploadedJson = [
  {
    "image": "https://www.significados.com.br/foto/camelia-29.jpg",
    "location": "Parque da Macaca, Aveiro",
    "request_date": "26-Jun-2022",
    "specimen_id": 2
  },
  {
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA5mAFxS9mjuuD-AWAGB_z1676LSGYIBoNA&usqp=CAU",
    "location": "Estufa Fria, Lisboa",
    "request_date": "20-May-2022",
    "specimen_id": 3
  },
  {
    "image":
        "https://media.istockphoto.com/photos/white-camellia-flower-isolated-on-white-background-picture-id1251528600?k=20&m=1251528600&s=612x612&w=0&h=AW64ZIfakH0ROp3WJeh_Gd5bjaJtOOyokx-NMjAho7E=",
    "location": "Jardim Botânico do Porto",
    "request_date": "01-Jan-2022",
    "specimen_id": 7
  }
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Home createState() => Home();
}

class Home extends State<HomePage> with WidgetsBindingObserver {
  late final Future? specimenMapFuture;
  late final Future? recentlyUploadedFuture;
  @override
  void initState() {
    super.initState();
    specimenMapFuture = api.getMapSpecimens();
    recentlyUploadedFuture = api.getRecentlyUploadedSpecimens();
    WidgetsBinding.instance.addObserver(this);
  }

  final api = APIService();
  List<LatLng> _latLngList = [];
  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var screenSize = MediaQuery.of(context).size;

    User? user = context.watch<UserProvider>().user;

    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(children: [
        const SizedBox(
            child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text('Camellia Cultivar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      )),
                ))),
        Container(
            height: screenSize.height / 8.25,
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ", ${user?.firstName} ",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            )),
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: const Color(0x00064e3b)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(children: [
              SizedBox(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      const Text(
                        'Recently uploaded Requests',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      FutureBuilder(
                        future: recentlyUploadedFuture,
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

                          if (snapshot.hasData &&
                              (snapshot.data as List).isNotEmpty) {
                            List<Map<String, dynamic>> specimens =
                                (snapshot.data!) as List<Map<String, dynamic>>;

                            return _buildRecentlyUploaded(context, specimens);
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text('Something went wrong!')],
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Divider(
                          height: screenSize.height / 27.52,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const Divider(
                          height: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: primaryColor,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Text('Camellia Map',
                              style:
                                  TextStyle(fontSize: 20, color: primaryColor))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: specimenMapFuture,
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
                    var specimens = snapshot.data! as List;
                    return _buildMap(context, specimens);
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('Something went wrong!')],
                  );
                },
              )
              // r
            ])),
      ]),
      bottomNavigationBar: const BotNavbar(pageIndex: 1),
    );
  }

  Widget _buildRecentlyUploaded(
      BuildContext context, List<Map<String, dynamic>> recentSpecimens) {
    _handleIdentify(Map<String, dynamic> specimen) {
      List<String> images =
          (specimen["photos"] as List).map((pic) => pic as String).toList();
      Question question =
          Question(specimenId: specimen["specimenId"] as int, images: images);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UniqueQuizPage(question: question)));
    }

    Color primaryColor = Theme.of(context).primaryColor;
    var screenSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
          height: 250,
          viewportFraction: 0.8,
          autoPlay: true,
          enableInfiniteScroll: false,
          enlargeStrategy: CenterPageEnlargeStrategy.height),
      items: [
        for (int i = 0; i < recentSpecimens.length; i++)
          Card(
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.only(bottom: 100),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: SizedBox(
                        // width: screenSize.width / 1.5,
                        height: 120,
                        child: (recentSpecimens.elementAt(i)["photos"] as List)
                                .isNotEmpty
                            ? Image.network(
                                recentSpecimens
                                    .elementAt(i)["photos"][0]
                                    .toString(),
                                height: screenSize.height / 5.5,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              )
                            : const Center(
                                child: Text("No images to show"),
                              ),
                      )),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 30,
                      color: primaryColor,
                    ),
                    Text(recentSpecimens.elementAt(i)["garden"].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(recentSpecimens.elementAt(i)["owner"].toString(),
                      style: const TextStyle(fontSize: 12))
                ]),
                const SizedBox(height: 10),
                MaterialButton(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    color: primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(150.0))),
                    onPressed: () => {
                          _handleIdentify(recentSpecimens.elementAt(i)),
                        },
                    child: const Text(
                      'Identify',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))
              ],
            ),
            elevation: 3,
            shadowColor: Colors.blueGrey,
          ),
      ],
    );
  }

  Widget _buildMap(BuildContext context, List<dynamic> specimens) {
    Color primaryColor = Theme.of(context).primaryColor;
    double _zoom = 1;

    _latLngList =
        specimens.map((specimen) => specimen!["coords"] as LatLng).toList();
    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 30,
              height: 30,
              builder: (context) => Icon(
                Icons.location_on_outlined,
                size: 30,
                color: primaryColor,
              ),
            ))
        .toList();

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text("Click on the map to see the specimens",
                style: TextStyle(color: Colors.grey[500]))),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: FlutterMap(
            options: MapOptions(
                center: _latLngList.isNotEmpty ? _latLngList[0] : LatLng(0, 0),
                zoom: _zoom,
                plugins: [
                  MarkerClusterPlugin(),
                ],
                onTap: (_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowFullMap(specimens)))),
            layers: [
              TileLayerOptions(
                minZoom: 1,
                maxZoom: 18,
                backgroundColor: primaryColor,
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerClusterLayerOptions(
                // maxClusterRadius: 190,
                disableClusteringAtZoom: 16,
                size: const Size(50, 50),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: _markers,
                polygonOptions: PolygonOptions(
                    borderColor: primaryColor,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                builder: (context, markers) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: Text(
                      '${markers.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
