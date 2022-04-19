import 'dart:io';

import 'package:camellia_cultivar/flower_icon.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:camellia_cultivar/navbar/botnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
// import 'package:flutter/image.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Camera createState() => Camera();
}

class Camera extends State<CameraPage> {
  File? imageFile;

  void _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 250,
        maxWidth: 500,
        imageQuality: 100);
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getFromCamera();
    return Scaffold(
      body: ListView(
        children: [
          // SizedBox(
          //   height: 50,
          // ),
          imageFile != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.file(imageFile!),
                  ],
                )
              // Container(
              //     width: 50,
              //     child: Image.file(imageFile!),
              //   )
              : Container(
                  child: Icon(
                    FlowerIcon.new_specimen3,
                    color: const Color(0xFF064E3B),
                    size: MediaQuery.of(context).size.width * .6,
                  ),
                ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: const Text('Camera'),
                onPressed: () {
                  _getFromCamera();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                ),
              ))
        ],
      ),
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
