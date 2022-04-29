import 'dart:io';

import 'package:camellia_cultivar/flower_icon.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:camellia_cultivar/navbar/button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'homepage.dart';
// import 'package:flutter/image.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Camera createState() => Camera();
}

class Camera extends State<CameraPage> {
  File? imageFile;

  // ignore: non_constant_identifier_names
  List specimen_images = [];

  void _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  int currentImg = 0;

  CarouselController controller = CarouselController();

  FocusNode myFocusNode = FocusNode();

  MapController _mapController = MapController();

  Position? _position = null;

  void _getCurrentPosition() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  // void initState() {
  //   getLocation();
  //   print(position);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final PopupController _popupController = PopupController();
    double _zoom = 7;
    LatLng location = _position == null
        ? LatLng(40.6384943, -8.6540832)
        : LatLng(_position!.latitude, _position!.longitude);
    LatLng? actualLocation = _position != null
        ? LatLng(_position!.latitude, _position!.longitude)
        : null;
    List<Marker> markers = [
      Marker(
        point: location,
        width: 100,
        height: 100,
        builder: (context) => const Icon(
          Icons.location_on,
          size: 20,
          color: Color(0xFF064E3B),
        ),
      )
    ];

    specimen_images = [
      imageFile,
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA5mAFxS9mjuuD-AWAGB_z1676LSGYIBoNA&usqp=CAU',
      'https://media.istockphoto.com/photos/white-camellia-flower-isolated-on-white-background-picture-id1251528600?k=20&m=1251528600&s=612x612&w=0&h=AW64ZIfakH0ROp3WJeh_Gd5bjaJtOOyokx-NMjAho7E='
    ];
    void _removeimg(int idx) {
      setState(() {
        specimen_images.removeAt(idx);
      });
    }

    print(specimen_images);

    // _getFromCamera();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      // SingleChildScrollView(
      //     child: Column(children: <Widget>[
      body: Container(
          // height: 18,
          margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF064E3B),
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Center(
                    child: Text('New Specimen',
                        // textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xFF064E3B), fontSize: 22)),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Color(0xFF064E3B),
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage(
                                    title: '',
                                  )));
                    },
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              imageFile != null
                  ? Column(
                      children: [
                        SizedBox(
                            height: 190,
                            child: Stack(children: [
                              CarouselSlider(
                                  carouselController: controller,
                                  options: CarouselOptions(
                                    aspectRatio: 2,
                                    viewportFraction: 0.9,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    enableInfiniteScroll: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentImg = index;
                                      });
                                    },
                                  ),
                                  items: [
                                    // for (int i = 0;
                                    //     i < specimen_images.length;
                                    //     i++)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.file(specimen_images[0]),
                                    ),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.network(specimen_images[1]),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.network(specimen_images[2]),
                                    ),
                                  ]),
                              Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: MaterialButton(
                                    color: const Color(0xFF064E3B),
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      _removeimg(currentImg);
                                      // setState(() {
                                      //   specimen_images.removeAt(currentImg);
                                      //   print(specimen_images);
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 25,
                                      color: Color(0xFFE7EEEC),
                                    ),
                                  ))
                            ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              specimen_images.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : const Color(0xFF064E3B))
                                        .withOpacity(currentImg == entry.key
                                            ? 0.9
                                            : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        GestureDetector(
                            onTap: () {
                              _getFromCamera();
                            },
                            child: Container(
                                width: 100,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color(0xFF064E3B),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    Text(
                                      ' Add',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ))),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        _getFromCamera();
                      },
                      child: Container(
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Color(0xFF064E3B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  'Add\nSpecimen\nPicture',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      )),
              SizedBox(
                  width: 250,
                  child: Center(
                      child: Column(
                    children: [
                      TextFormField(
                        cursorColor: const Color(0xFF064E3B),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Color(0xFF064E3B)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          labelText: 'Garden',
                        ),
                      ),
                      TextFormField(
                        focusNode: myFocusNode,
                        cursorColor: const Color(0xFF064E3B),
                        decoration: const InputDecoration(
                          //Color(0xFF064E3B)
                          labelStyle: TextStyle(color: Color(0xFF064E3B)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF064E3B)),
                          ),
                          labelText: 'Owner',
                        ),
                      ),
                    ],
                  ))),
              const Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: SizedBox(
                        height: 120,
                        width: 150,
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            center: actualLocation != null
                                ? actualLocation
                                : location, //change center with geolocation
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
                              markers: markers,
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
                        )),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Column(
                    children: [
                      _position != null
                          ? Text("Lat:" +
                              _position!.latitude.toString() +
                              "\n" +
                              "Long:" +
                              _position!.longitude.toString())
                          : const Text('lat\nlong'),
                      const Padding(padding: EdgeInsets.all(5)),
                      MaterialButton(
                          padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
                          color: const Color(0xFF064E3B),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          onPressed: () {
                            _getCurrentPosition();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.location_on,
                                size: 40,
                                color: Color(0xFFE7EEEC),
                              ),
                              Text(
                                'Set current\nlocation',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ]),
          )),

      bottomNavigationBar: const BotNavbar(pageIndex: 0),
    );
  }
}

// class ServerIpText extends StatefulWidget {
//   final String serverIP;

//   const ServerIpText({Key? key, required this.serverIP}) : super(key: key);

//   @override
//   _ServerIpTextState createState() => _ServerIpTextState();
// }

// class _ServerIpTextState extends State<ServerIpText> {
//   @override
//   Widget build(BuildContext context) {
//     return Text(widget.serverIP);
//   }
// }
