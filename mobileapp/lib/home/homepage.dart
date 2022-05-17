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
import 'costum_popup.dart';
import 'example_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Home createState() => Home();
}

class Home extends State<HomePage> with WidgetsBindingObserver {
  List recently_uploaded = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final isBackground = state == AppLifecycleState.resumed;

    if (isBackground) {
      const storage = FlutterSecureStorage();
      String expiresIn = await storage.read(key: "expiresIn") ?? "";

      if (expiresIn.isNotEmpty &&
          DateTime.now().compareTo(DateTime.parse(expiresIn)) < 0) {
        if (await LocalAuthApi.hasBiometrics()) {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (!isAuthenticated) {
            User user = context.read<UserProvider>().user as User;
            await logout(context, user);

            Navigator.popUntil(context, (route) => route.isFirst);
          }
        } else {
          User user = context.read<UserProvider>().user as User;
          await logout(context, user);
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    User? user = context.watch<UserProvider>().user;

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
              width: 300,
              height: 300,
              builder: (context) => GestureDetector(
                  onTap: () {
                    setState(() {
                      infoWindowVisible = !infoWindowVisible;
                    });
                  },
                  child: _buildCustomMarker()),
              // Icon(
              //   Icons.location_on,
              //   size: 60,
              //   color: primaryColor,
              // ),
            ))
        .toList();

    Map<Marker, bool> _openPopUp = {};

    for (var element in _markers) {
      _openPopUp[element] = false;
    }

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
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.account_circle_outlined),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                )
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
                            aspectRatio: 1.3,
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
                height: MediaQuery.of(context).size.height - 140,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _latLngList[0],
                    bounds: LatLngBounds.fromPoints(_latLngList),
                    zoom: _zoom,
                    plugins: [
                      MarkerClusterPlugin(),
                    ],
                    onTap: (_) => setState(() {
                      infoWindowVisible = false;
                    }),
                  ),
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

  Stack _buildCustomMarker() {
    return Stack(
      children: <Widget>[popup(), marker()],
    );
  }

  var infoWindowVisible = false;

  Opacity popup() {
    return Opacity(
      opacity: infoWindowVisible ? 1.0 : 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 279.0,
        height: 270.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: infoWindowVisible ? CustomPopup() : null,
      ),
    );
  }

  Opacity marker() {
    return Opacity(
      child: Container(
        alignment: Alignment.center,
        child: const Icon(
          Icons.location_on_outlined,
          size: 30,
          color: Color(0xFF064E3B),
        ),
      ),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }
}
