import 'dart:io';

import 'package:camellia_cultivar/navbar/new_specimen_icon.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:camellia_cultivar/navbar/button.dart';
import 'package:camellia_cultivar/new_specimen/upov_characteristics.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../home/homepage.dart';
import '../home/image_full_slider_map.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class NewSpecimenPage extends StatefulWidget {
  const NewSpecimenPage({Key? key}) : super(key: key);

  @override
  NewSpecimen createState() => NewSpecimen();
}

class NewSpecimen extends State<NewSpecimenPage> {
  List specimen_images = [];
  List specimen_images_urls = [];

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      specimen_images.add(File(pickedFile!.path));
      if (specimen_images.length == 1) currentImg = specimen_images.length - 1;
    });
  }

  int currentImg = 0;

  CarouselController controller = CarouselController();

  FocusNode myFocusNode = FocusNode();

  MapController _mapController = MapController();

  Position? _position = null;

  final gardenController = TextEditingController();
  final ownerController = TextEditingController();

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
  void dispose() {
    super.dispose();
    ownerController.dispose();
    gardenController.dispose();
  }

  Future<void> uploadInAzure() async {
    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;AccountName=camelliacultivarstorage2;AccountKey=kPhGXW18u8dybJNKeMLHjmBd3F8ta3MC0ORiAibQyX5dURLBENCZdsmhT0qOI3OEbRUFE8KLHPRf+AStvoq0XQ==;EndpointSuffix=core.windows.net');
    var baseUrl = 'https://camelliacultivarstorage2.blob.core.windows.net';
    var urls = [];

    for (File f in specimen_images) {
      var azureImgUrl = '/imagestorage/${basename(f.path)}';
      var content = await f.readAsBytes();
      String? contentType = lookupMimeType(basename(f.path));

      urls.add(baseUrl + azureImgUrl);

      await storage.putBlob(azureImgUrl,
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.BlockBlob);
    }
    setState(() {
      specimen_images_urls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
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
        builder: (context) => Icon(
          Icons.location_on,
          size: 20,
          color: primaryColor,
        ),
      )
    ];

    void _removeimg() {
      setState(() {
        specimen_images.removeAt(currentImg);
        if (currentImg == specimen_images.length) currentImg--;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: Container(
          margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text('New Specimen',
                            style: TextStyle(color: primaryColor, fontSize: 22),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: primaryColor,
                        size: 25,
                      ),
                      onPressed: () {
                        if (ownerController.text.isEmpty ||
                            gardenController.text.isEmpty ||
                            specimen_images.isEmpty ||
                            actualLocation == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text(
                                    'Please, fill in the required fields',
                                    style: TextStyle(color: Colors.red),
                                  )));
                        } else {
                          uploadInAzure();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'ID request sent for validation.',
                                  style: TextStyle(color: Colors.black),
                                )),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      },
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              specimen_images.isNotEmpty
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
                                    for (int i = 0;
                                        i < specimen_images.length;
                                        i++)
                                      GestureDetector(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: Image.file(specimen_images[i]),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SliderShowFullmages(
                                                        listImagesModel:
                                                            specimen_images,
                                                        current: currentImg,
                                                        isNetworkImg: false,
                                                      )));
                                        },
                                      )
                                  ]),
                              Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: MaterialButton(
                                    color: primaryColor,
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      _removeimg();
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
                                            : primaryColor)
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
                                decoration: BoxDecoration(
                                    color: primaryColor,
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
                        decoration: BoxDecoration(
                            color: primaryColor,
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
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelText: 'Garden',
                        ),
                        controller: gardenController,
                      ),
                      TextFormField(
                        focusNode: myFocusNode,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          //primaryColor
                          labelStyle: TextStyle(color: primaryColor),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelText: 'Owner',
                        ),
                        controller: ownerController,
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
                            center: actualLocation ??
                                location, //change center with geolocation
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
                              polygonOptions: PolygonOptions(
                                  borderColor: primaryColor,
                                  color: Colors.black12,
                                  borderStrokeWidth: 3),
                              builder: (context, markers) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
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
                          : const Text('Lat:\nLong:'),
                      const Padding(padding: EdgeInsets.all(5)),
                      MaterialButton(
                          padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
                          color: primaryColor,
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
              Container(
                width: 350,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(bottom: 10),
                child: const UpovCharacteristics(),
              ),
            ]),
          )),
      bottomNavigationBar: const BotNavbar(pageIndex: 0),
    );
  }
}
