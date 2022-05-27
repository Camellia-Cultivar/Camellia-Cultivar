import 'dart:convert';

import 'package:camellia_cultivar/home/map_page.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:camellia_cultivar/profilepage.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/utils/auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';

import '../new_specimen/new_specimen.dart';
import 'specimen_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Home createState() => Home();
}

class Home extends State<HomePage> with WidgetsBindingObserver {
  List recently_uploaded = [];

  List<LatLng> _latLngList = [];
  List<Marker> _markers = [];

  late Map<LatLng, bool> _openPopUp;

  Map<LatLng, bool> initOpenPopUp() {
    Map<LatLng, bool> pop = {};
    for (var latlng in _latLngList) {
      pop[latlng] = false;
    }
    return pop;
  }

  @override
  void initState() {
    _latLngList = [
      LatLng(40.6384943, -8.6540832),
      LatLng(40.6391863, -8.6563771),
      LatLng(40.6364017, -8.6532305),
      LatLng(40.6335806, -8.6519005),
      LatLng(40, -8),
      LatLng(41.6335806, -7.6519005),
      LatLng(40.6335806, -8.6419005),
      LatLng(39.6335806, -9.0419005)
    ];
    _openPopUp = initOpenPopUp();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    User? user = context.watch<UserProvider>().user;

    // final PopupController _popupController = PopupController();
    // MapController _mapController = MapController();
    double _zoom = 1;

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

    recently_uploaded = [
      'https://www.significados.com.br/foto/camelia-29.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA5mAFxS9mjuuD-AWAGB_z1676LSGYIBoNA&usqp=CAU',
      'https://media.istockphoto.com/photos/white-camellia-flower-isolated-on-white-background-picture-id1251528600?k=20&m=1251528600&s=612x612&w=0&h=AW64ZIfakH0ROp3WJeh_Gd5bjaJtOOyokx-NMjAho7E='
    ];

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
            height: 100,
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
                border: Border.all(width: 1, color: const Color(0x064E3B)),
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
                      CarouselSlider(
                        options: CarouselOptions(
                            aspectRatio: 1.4,
                            viewportFraction: 0.8,
                            autoPlay: true,
                            enableInfiniteScroll: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height),
                        items: [
                          for (int i = 0; i < recently_uploaded.length; i++)
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                    // padding: EdgeInsets.only(bottom: 100),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child: Image.network(
                                        recently_uploaded[i],
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 30,
                                        color: primaryColor,
                                      ),
                                      const Text('Parque da Macaca, Aveiro',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('26-Jun-2022',
                                            style: TextStyle(fontSize: 12))
                                      ]),
                                  const SizedBox(height: 10),
                                  MaterialButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          60, 10, 60, 10),
                                      color: primaryColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(150.0))),
                                      onPressed: () {
                                        //change to page of quiz with that identification request
                                      },
                                      child: const Text(
                                        'Identify',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ))
                                ],
                              ),
                              elevation: 3,
                              shadowColor: Colors.blueGrey,
                            ),
                        ],
                      ),
                      // GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   const NewSpecimenPage()));
                      //     },
                      //     child: Container(
                      //         height: 125,
                      //         decoration: BoxDecoration(
                      //             color: primaryColor,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(15))),
                      //         child: Row(
                      //           children: const [
                      //             Padding(
                      //               padding: EdgeInsets.only(left: 20),
                      //             ),
                      //             Center(
                      //                 child: Icon(
                      //               Icons.add_circle,
                      //               color: Colors.white,
                      //               size: 50,
                      //             )),
                      //             Padding(
                      //               padding: EdgeInsets.only(left: 10),
                      //             ),
                      //             Text(
                      //               'New Identification\nRequest',
                      //               style: TextStyle(
                      //                   fontSize: 20,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold),
                      //             )
                      //           ],
                      //         ))),
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
              const Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: FlutterMap(
                  options: MapOptions(
                      center: _latLngList[0],
                      zoom: _zoom,
                      plugins: [
                        MarkerClusterPlugin(),
                      ],
                      onTap: (_) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShowFullMap()))),
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
              // r
            ])),
      ]),
      bottomNavigationBar: const BotNavbar(pageIndex: 1),
    );
  }
}
