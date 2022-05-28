import 'dart:io';

import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/login.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/new_specimen/new_specimen.dart';
import 'package:camellia_cultivar/profile_page.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import "package:camellia_cultivar/extensions/string_apis.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'api/api_service.dart';
import 'navbar/botnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'new_specimen/new_specimen.dart';

import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  File? profileImage;
  final _picker = ImagePicker();
  Future<void> _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  late String profileImageUrl;

  Future<void> uploadInAzure(User user) async {
    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;AccountName=camelliacultivarstorage2;AccountKey=kPhGXW18u8dybJNKeMLHjmBd3F8ta3MC0ORiAibQyX5dURLBENCZdsmhT0qOI3OEbRUFE8KLHPRf+AStvoq0XQ==;EndpointSuffix=core.windows.net');
    var baseUrl = 'https://camelliacultivarstorage2.blob.core.windows.net';

    var azureImgUrl =
        '/imagestorage/${user.id}/${basename(profileImage!.path)}';
    var content = await profileImage!.readAsBytes();
    String? contentType = lookupMimeType(basename(profileImage!.path));

    await storage.putBlob(azureImgUrl,
        bodyBytes: content, contentType: contentType, type: BlobType.BlockBlob);

    setState(() {
      profileImageUrl = baseUrl + azureImgUrl;
    });
  }
  final api = APIService();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var screenSize = MediaQuery.of(context).size;

    User? user = context.read<UserProvider>().user;

    if (user == null) {
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
      return const Scaffold();
    }

    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    void handleSubmit(BuildContext context, User user) async {
      if (_formKey.currentState!.validate()) {
        user.email = emailController.text;
        user.firstName = firstNameController.text;
        user.lastName = lastNameController.text;
        // user.password = passwordController.text.isNotEmpty
        //     ? passwordController.text
        //     : user.password;

        if (passwordController.text.isNotEmpty) {
          var password = passwordController.text;
          await api.updatePassword(user.id, password);
        }

        // try {
        //   final dbHelper = DatabaseHelper.instance;
        //   await dbHelper.update("users", user.toJson());
        //   context.read<UserProvider>().setUser(user);
        //   Navigator.pop(context,
        //       MaterialPageRoute(builder: (context) => const ProfilePage()));
        // } on Exception catch (e) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text('Failed to submit changes!'),
        //         backgroundColor: Colors.red),
        //   );
        //   return;
        // }

        try {
          await api.updateUser(user);
          context.read<UserProvider>().setUser(user);
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to submit changes!'),
                backgroundColor: Colors.red),
          );
          return;
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6F7),
      body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
        Form(
            key: _formKey,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
                height: screenSize.height / 1.3,
                width: screenSize.width / 1.2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Wrap(
                            spacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              BackButton(
                                color: primaryColor,
                              ),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: screenSize.height / 35,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            top: screenSize.height / 30,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenSize.height / 8,
                                width: screenSize.width / 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.network(
                                      user.profileImage as String),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: SizedBox(
                                        width: screenSize.width / 1.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.person_outlined,
                                              color: primaryColor,
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(10)),
                                            SizedBox(
                                                width: screenSize.width / 2.5,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: "First Name",
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                    ),
                                                    border:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                    ),
                                                  ),
                                                  controller:
                                                      firstNameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'First name is required';
                                                    }
                                                    return null;
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: SizedBox(
                                          width: screenSize.width / 1.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: screenSize.width /
                                                          10)),
                                              SizedBox(
                                                  width: screenSize.width / 2.5,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      hintText: "Last Name",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
                                                      ),
                                                      border:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
                                                      ),
                                                    ),
                                                    controller:
                                                        lastNameController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Last name is required';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: SizedBox(
                                            width: screenSize.width / 1.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  const IconData(0xf018,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  color: primaryColor,
                                                ),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.all(10)),
                                                SizedBox(
                                                    width:
                                                        screenSize.width / 2.5,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Email",
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ),
                                                      controller:
                                                          emailController,
                                                      validator: (input) =>
                                                          input != null &&
                                                                  input
                                                                      .isValidEmail()
                                                              ? null
                                                              : "Invalid email",
                                                    )),
                                              ],
                                            ))),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: SizedBox(
                                            width: screenSize.width / 1.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  const IconData(0xf052b,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  color: primaryColor,
                                                ),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.all(10)),
                                                SizedBox(
                                                    width:
                                                        screenSize.width / 2.5,
                                                    child: TextFormField(
                                                      obscureText: true,
                                                      enableSuggestions: false,
                                                      autocorrect: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "New Password",
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ),
                                                      controller:
                                                          passwordController,
                                                      validator: (value) {
                                                        if ((value == null ||
                                                                value
                                                                    .isEmpty) &&
                                                            confirmPasswordController
                                                                .text
                                                                .isNotEmpty) {
                                                          return 'Password is required!';
                                                        }
                                                        return null;
                                                      },
                                                    )),
                                              ],
                                            ))),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: SizedBox(
                                            width: screenSize.width / 1.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            screenSize.width /
                                                                10)),
                                                SizedBox(
                                                    width:
                                                        screenSize.width / 2.5,
                                                    child: TextFormField(
                                                      obscureText: true,
                                                      enableSuggestions: false,
                                                      autocorrect: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Confirm Password",
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ),
                                                      controller:
                                                          confirmPasswordController,
                                                      validator: (input) => passwordController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              passwordController
                                                                      .text !=
                                                                  input
                                                          ? "Passwords don't match!"
                                                          : null,
                                                    )),
                                              ],
                                            ))),
                                  ]),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              SizedBox(
                                height: screenSize.height / 12.5,
                                width: screenSize.width / 1.8,
                                child: TextButton(
                                    onPressed: () =>
                                        {handleSubmit(context, user)},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(150.0),
                                              side: const BorderSide(
                                                  color: Colors.white))),
                                    ),
                                    child: Text("Save Changes".toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300))),
                              ),
                            ],
                          ))
                    ])))
      ]))),
    );
  }
}