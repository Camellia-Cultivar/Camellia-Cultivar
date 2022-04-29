import 'dart:io';

import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';

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
    final PopupController _popupController = PopupController();
    MapController _mapController = MapController();
    double _zoom = 7;
    List<LatLng> _latLngList = [
      LatLng(40.6384943, -8.6540832),
      LatLng(40.6391863, -8.6563771),
      LatLng(40.6364017, -8.6532305),
      LatLng(40.6335806, -8.6519005),
      LatLng(40, -8),
      LatLng(41.6335806, -7.6519005),
      LatLng(40.6335806, -8.6419005),
      LatLng(39.6335806, -9.0419005)
    ];
    List<Marker> _markers = [];

    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 50,
              height: 50,
              builder: (context) => const Icon(
                Icons.location_on,
                size: 60,
                color: Color(0xFF064E3B),
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF064E3B),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF064E3B),
      //   // title: Text("Home Page"),
      // ),
      body: Column(children: [
        // SliverFixedExtentList(delegate: SliverChildBuilderDelegate((context, index) => ), itemExtent: 50)
        const SizedBox(
            height: 80,
            child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text('Camellia Cultivar',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ))),
        Container(
            height: 100,
            color: const Color(0xFF064E3B),
            // margin: EdgeInsets.only(left: 50, right: 50),

            // const BorderRadius.all(const Radius.circular(8))),
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
                const Text(
                  ', Emerald ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  // textAlign: TextAlign.center,
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.account_circle_outlined),
                  color: Colors.white,
                  onPressed: () {},
                )
              ],
            )),
        Expanded(
          child: Container(
              height: 600,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: const Color(0x064E3B)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              // margin: const Margin,
              child: ListView(
                  // alignment: Alignment.center,
                  children: [
                    // Stack(
                    //   children: [
                    // ListView(children: [
                    SizedBox(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                                          builder: (context) =>
                                              const CameraPage()));
                                },
                                child: Container(
                                    height: 125,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF064E3B),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF064E3B),
                                ),
                                Padding(padding: EdgeInsets.only(left: 10)),
                                Text('Camellia Map',
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFF064E3B)))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    SizedBox(
                      // padding: EdgeInsets.only(top: 10),
                      height: 600,
                      // child: Positioned(
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          center:
                              _latLngList[0], //change center with geolocation
                          bounds: LatLngBounds.fromPoints(_latLngList),
                          zoom: _zoom,
                          plugins: [
                            MarkerClusterPlugin(),
                          ],
                          onTap: (_) => _popupController.hidePopup(),
                        ),
                        layers: [
                          TileLayerOptions(
                            minZoom: 1,
                            maxZoom: 18,
                            backgroundColor: Colors.black,
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerClusterLayerOptions(
                            maxClusterRadius: 190,
                            disableClusteringAtZoom: 16,
                            size: const Size(50, 50),
                            fitBoundsOptions: const FitBoundsOptions(
                              padding: EdgeInsets.all(50),
                            ),
                            markers: _markers,
                            polygonOptions: const PolygonOptions(
                                borderColor: Color(0xFF064E3B),
                                color: Colors.black12,
                                borderStrokeWidth: 3),
                            builder: (context, markers) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF064E3B),
                                    shape: BoxShape.circle),
                                child: Text(
                                  '${markers.length}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      // ),
                    ),

                    // const BotNavbar(pageIndex: 1)
                    // ])
                    // Positioned(bottom: 0, child: BotNavbar(pageIndex: 1)),
                    // ],
                    // r
                  ])),
        ),
        // const Positioned(bottom: 0, child: BotNavbar(pageIndex: 1)),
        // const BotNavbar(pageIndex: 1)
      ]),
      bottomNavigationBar: const BotNavbar(pageIndex: 1),
    );
  }
}
