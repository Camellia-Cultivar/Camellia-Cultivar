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
import 'package:geocoding/geocoding.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../api/api_service.dart';
import '../home/homepage.dart';
import '../home/image_full_slider_map.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../model/upov_category.dart';
import '../model/upov_subcategory.dart';
import '../model/upov_subcategory_option.dart';
import '../model/user.dart';
import '../providers/user.dart';
import 'package:geocoding/geocoding.dart';

class NewSpecimenPage extends StatefulWidget {
  const NewSpecimenPage({Key? key}) : super(key: key);

  @override
  NewSpecimen createState() => NewSpecimen();
}

class NewSpecimen extends State<NewSpecimenPage> {
  List specimen_images = [];
  List<String> specimen_images_urls = [];
  final api = APIService();
  @override
  void initState() {
    super.initState();
    upovFuture = api.getUpovCharacteristics();
  }

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

  final MapController _mapController = MapController();

  LatLng? userLocation;
  var userAddress;

  final gardenController = TextEditingController();
  final ownerController = TextEditingController();

  late final Future? upovFuture;
  Map controllers = {
    'main color': TextEditingController(),
    'secondary color': TextEditingController()
  };

  void _getCurrentPosition(BuildContext context) async {
    try {
      Position position = await _determinePosition();
      try {
        List<Placemark> placemarks = await GeocodingPlatform.instance
            .placemarkFromCoordinates(position.latitude, position.longitude);
        var first_address = placemarks.first;
        setState(() {
          userAddress =
              "${first_address.street}, ${first_address.locality}, ${first_address.country}";
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Couldn't get the address",
              style: TextStyle(color: Colors.white),
            )));
        setState(() {
          userAddress = "default address";
        });
      }
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Need google services to get your location.",
            style: TextStyle(color: Colors.white),
          )));
    }
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

  Future<void> uploadInAzure(User user) async {
    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;AccountName=camelliacultivarstorage2;AccountKey=kPhGXW18u8dybJNKeMLHjmBd3F8ta3MC0ORiAibQyX5dURLBENCZdsmhT0qOI3OEbRUFE8KLHPRf+AStvoq0XQ==;EndpointSuffix=core.windows.net');
    var baseUrl = 'https://camelliacultivarstorage2.blob.core.windows.net';
    List<String> urls = [];

    for (File f in specimen_images) {
      var azureImgUrl = '/imagestorage/${user.id}/${basename(f.path)}';
      var content = await f.readAsBytes();
      String? contentType = lookupMimeType(basename(f.path));

      urls.add(baseUrl + azureImgUrl);

      await storage.putBlob(azureImgUrl,
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.BlockBlob);
    }
    if (specimen_images_urls.isEmpty) {
      setState(() {
        specimen_images_urls = urls;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  Map<int, dynamic> selectedUpovs = {};

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    final PopupController _popupController = PopupController();
    double _zoom = 1;

    List<Marker> markers = [
      Marker(
        point: userLocation,
        width: 20,
        height: 20,
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

    User? user = context.watch<UserProvider>().user;

    void handleSubmit() async {
      if (specimen_images_urls.isEmpty) {
        setState(() {
          specimen_images_urls = [
            "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F24%2F2019%2F05%2Fgettyimages-1038704710-2000.jpg"
          ];
        });
      }

      if (!_formKey.currentState!.validate() ||
          specimen_images_urls.isEmpty ||
          userLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              'Please fill the first 4 fields',
              style: TextStyle(color: Colors.red),
            )));
        List<Map<String, dynamic>> characteristicValues = [];

        for (int id in selectedUpovs.keys) {
          var input = selectedUpovs[id];
          if (input is int) {
            characteristicValues.add({
              "characteristic": {"id": id},
              "id": input
            });
          } else if (input is String) {
            characteristicValues.add({
              "characteristic": {"id": id},
              "descriptor": input
            });
          }
        }
        // Map<String, dynamic> specimenToUpload = {
        //   'owner': ownerController.text.trim(),
        //   'photos': specimen_images_urls,
        //   'address': userAddress,
        //   'garden': gardenController.text.trim(),
        //   'latitude': userLocation!.latitude,
        //   'longitude': userLocation!.longitude,
        //   'characteristicValues': characteristicValues
        // };
      } else {
        if (userAddress == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Couldn't get the address of coordinates",
                style: TextStyle(color: Colors.red),
              )));
          return;
        }
        uploadInAzure(user!);
        //       "owner": ownerName,
        //  "photos":[ link1, link2, … ],
        //  "address": address,
        //  "latitude": latitude (double),
        //  "longitude": longitude (double),
        //  "garden":"a",
        //  "characteristicValues":[
        //     	{"characteristic":{"id":4},"id":14}, // valores restritos (opções)
        //     	{"characteristic":{"id":43},"descriptor":1000}, // valores abertos
        //  ]

        List<Map<String, dynamic>> characteristicValues = [];

        for (int id in selectedUpovs.keys) {
          var input = selectedUpovs[id];
          if (input is int) {
            characteristicValues.add({
              "characteristic": {"id": id},
              "id": input
            });
          } else if (input is String) {
            characteristicValues.add({
              "characteristic": {"id": id},
              "descriptor": input
            });
          }
        }

        Map<String, dynamic> specimenToUpload = {
          'owner': ownerController.text.trim(),
          'photos': specimen_images_urls,
          'address': userAddress,
          'garden': gardenController.text.trim(),
          'latitude': userLocation!.latitude,
          'longitude': userLocation!.longitude,
          'characteristicValues': characteristicValues
        };
        var statusCode = await api.postSpecimenRequest(specimenToUpload);
        if (statusCode == 200 || statusCode == 201 || statusCode == 202) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'ID request sent for validation.',
                  style: TextStyle(color: Colors.green),
                )),
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Something went wrong, please try again later.',
                  style: TextStyle(color: Colors.red),
                )),
          );
        }
      }
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
                  Positioned(
                      left: 0,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          })),
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
                        onPressed: () => {handleSubmit()}),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                                                CenterPageEnlargeStrategy
                                                    .height,
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
                                                  child: Image.file(
                                                      specimen_images[i]),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SliderShowFullmages(
                                                                listImagesModel:
                                                                    specimen_images,
                                                                current:
                                                                    currentImg,
                                                                isNetworkImg:
                                                                    false,
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
                                  children: specimen_images
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : primaryColor)
                                                    .withOpacity(
                                                        currentImg == entry.key
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
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required';
                                  }
                                },
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '*Required';
                                  }
                                },
                              ),
                            ],
                          ))),
                      const Padding(padding: EdgeInsets.all(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: SizedBox(
                                height: 120,
                                width: 150,
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    center:
                                        userLocation, //change center with geolocation
                                    zoom: _zoom,
                                    plugins: [
                                      MarkerClusterPlugin(),
                                    ],
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
                                            style: const TextStyle(
                                                color: Colors.white),
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
                              userLocation != null
                                  ? Text("Lat:" +
                                      userLocation!.latitude.toString() +
                                      "\n" +
                                      "Long:" +
                                      userLocation!.longitude.toString())
                                  : const Text('Lat:\nLong:'),
                              const Padding(padding: EdgeInsets.all(5)),
                              MaterialButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 20, 8),
                                  color: primaryColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  onPressed: () {
                                    _getCurrentPosition(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                    ],
                  )),
              Container(
                  width: 350,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FutureBuilder(
                    future: upovFuture,
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
                        var upovs = snapshot.data! as List;
                        return _buildUpovs(context, upovs);
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text('Something went wrong!')],
                      );
                    },
                  )
                  // child: upovs(context, upovs),
                  ),
            ]),
          )),
      bottomNavigationBar: const BotNavbar(pageIndex: 0),
    );
  }

  Widget _buildUpovs(BuildContext context, List upovs) {
    Color primaryColor = Theme.of(context).primaryColor;
    // Map<int, UpovSubcategoryOption> temp = {};
    // for (UpovCategory category in upovs) {
    //   for (UpovSubcategory subCategory in category.characteristics) {
    //     //   temp[subCategory.id] = UpovSubcategoryOption(
    //     //       value: 0, descriptor: "i don't know", id: 0);

    //     // for (UpovSubcategoryOption option in subCategory.options!) {
    //     //     temp[subCategory.id] = option;
    //     // }
    //     selectedValues[subCategory.id] =
    //         UpovSubcategoryOption(value: 0, descriptor: "i don't know", id: 0);
    //   }
    // }

    // for (int i = 0; i < upovs.length; i++) {
    //   var category = upovs[i];
    //   for (int j = 0; j < category.characteristics; j++) {
    //     var options = category.characteristics[j];
    //     for (int l = 0; j < options.options; l++) {
    //       var option = options.options[l];
    //       temp[i + j + l] = option;
    //     }
    //   }
    // }
    // setState(() {
    //   possibleValues = temp;
    // });
    return Column(children: [
      for (UpovCategory category in upovs)
        ExpansionTile(
            collapsedIconColor: primaryColor,
            collapsedTextColor: primaryColor,
            title: Text(
              category.category,
              style: const TextStyle(fontSize: 18.0),
            ),
            children: [
              for (UpovSubcategory subCategory in category.characteristics)
                subCategory.options!.isNotEmpty
                    ? SmartSelect<String>.single(
                        title: subCategory.name,
                        choiceItems: [
                          S2Choice<String>(
                              value: 0.toString(), title: "i don't know"),
                          for (UpovSubcategoryOption option
                              in subCategory.options!)
                            S2Choice<String>(
                                value: option.value.toString(),
                                title: option.descriptor)
                        ],
                        value: selectedUpovs[subCategory.id].toString(),
                        onChange: (selected) => setState(() =>
                            selected.value != "0"
                                ? selectedUpovs[subCategory.id] =
                                    int.parse(selected.value)
                                : null),
                        modalType: S2ModalType.popupDialog,
                      )
                    : _buildColorTextInput(subCategory)
            ])
    ]);
  }

  Widget _buildColorTextInput(UpovSubcategory subcategory) {
    Color black = Colors.black;
    FocusNode myFocusNode = FocusNode();
    return (Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          focusNode: myFocusNode,
          cursorColor: black,
          decoration: InputDecoration(
            //black
            labelStyle: TextStyle(color: black),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            labelText: subcategory.name,
          ),
          controller: controllers[subcategory.name],
          onChanged: (value) {
            setState(() {
              selectedUpovs[subcategory.id] = value;
            });
          },
        )));
  }
}

  // Widget upovs(BuildContext context, List upovs) {
  //   List<String> selectedValues = List.filled(50, 'idk');
  //   Color primaryColor = Theme.of(context).primaryColor;
  //   return Column(children: [
  //     for (UpovCategory category in upovs)
  //       ExpansionTile(
  //           collapsedIconColor: primaryColor,
  //           collapsedTextColor: primaryColor,
  //           title: Text(
  //             category.category,
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //           children: [
  //             for (UpovSubcategory subCategory in category.characteristics)
  //               subCategory.options != null
  //                   ? SmartSelect<String>.single(
  //                       title: subCategory.name,
  //                       choiceItems: [
  //                         S2Choice<String>(
  //                             value: 0.toString(), title: "i don't know"),
  //                         for (UpovSubcategoryOption option
  //                             in subCategory.options!)
  //                           S2Choice<String>(
  //                               value: option.value.toString(),
  //                               title: option.descriptor)
  //                       ],
  //                       value: selectedValues[subCategory.id - 1],
  //                       onChange: (selected) => setState(() =>
  //                           selectedValues[subCategory.id - 1] =
  //                               selected.value),
  //                       modalType: S2ModalType.popupDialog,
  //                     )
  //                   : _buildColorTextInput(context)
  //           ])
  //   ]);
  // }
// }

// Widget _buildColorTextInput(BuildContext context) {
//   Color primaryColor = Theme.of(context).primaryColor;
//   FocusNode myFocusNode = FocusNode();
//   final mainColorController = TextEditingController();
//   final secondaryColorController = TextEditingController();
//   return (Column(
//     children: [
//       TextFormField(
//         focusNode: myFocusNode,
//         cursorColor: primaryColor,
//         decoration: InputDecoration(
//           //primaryColor
//           labelStyle: TextStyle(color: primaryColor),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           labelText: 'Main Color',
//         ),
//         controller: mainColorController,
//       ),
//       TextFormField(
//         focusNode: myFocusNode,
//         cursorColor: primaryColor,
//         decoration: InputDecoration(
//           //primaryColor
//           labelStyle: TextStyle(color: primaryColor),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: primaryColor),
//           ),
//           labelText: 'Secondary Color',
//         ),
//         controller: secondaryColorController,
//       ),
//     ],
//   ));
// }


