import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/profilepage.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import "package:camellia_cultivar/extensions/string_apis.dart";
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    User? user = context.read<UserProvider>().user;

    if (user == null) {
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
        user.password = passwordController.text.isNotEmpty
            ? passwordController.text
            : user.password;

        try {
          final dbHelper = DatabaseHelper.instance;
          await dbHelper.update("users", user.toMap());
          context.read<UserProvider>().setUser(user);
          Navigator.pop(context);
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
            child: Form(
                key: _formKey,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    height: screenSize.height / 1.2,
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
                                  const BackButton(
                                    color: Color(0xFF064E3B),
                                  ),
                                  Text("Edit Profile",
                                      style: TextStyle(
                                          color: const Color(0xFF064E3B),
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
                                        "https://i.imgflip.com/2/1975nj.jpg",
                                      ),
                                    ),
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: SizedBox(
                                            width: screenSize.width / 1.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.person_outlined,
                                                  color: Color(0xFF064E3B),
                                                ),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.all(10)),
                                                SizedBox(
                                                    width:
                                                        screenSize.width / 2.5,
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: "First Name",
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF064E3B)),
                                                        ),
                                                        border:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xFF064E3B)),
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
                                          padding: EdgeInsets.only(bottom: 20),
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
                                                      width: screenSize.width /
                                                          2.5,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: "Last Name",
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF064E3B)),
                                                          ),
                                                          border:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xFF064E3B)),
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
                                                EdgeInsets.only(bottom: 20),
                                            child: SizedBox(
                                                width: screenSize.width / 1.8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      IconData(0xf018,
                                                          fontFamily:
                                                              'MaterialIcons'),
                                                      color: Color(0xFF064E3B),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(10)),
                                                    SizedBox(
                                                        width:
                                                            screenSize.width /
                                                                2.5,
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText: "Email",
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
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
                                                EdgeInsets.only(bottom: 20),
                                            child: SizedBox(
                                                width: screenSize.width / 1.8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      IconData(0xf052b,
                                                          fontFamily:
                                                              'MaterialIcons'),
                                                      color: Color(0xFF064E3B),
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(10)),
                                                    SizedBox(
                                                        width:
                                                            screenSize.width /
                                                                2.5,
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          enableSuggestions:
                                                              false,
                                                          autocorrect: false,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                "New Password",
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        14),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
                                                            ),
                                                          ),
                                                          controller:
                                                              passwordController,
                                                          validator: (value) {
                                                            if ((value ==
                                                                        null ||
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
                                                EdgeInsets.only(bottom: 20),
                                            child: SizedBox(
                                                width: screenSize.width / 1.8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            right: screenSize
                                                                    .width /
                                                                10)),
                                                    SizedBox(
                                                        width:
                                                            screenSize.width /
                                                                2.5,
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          enableSuggestions:
                                                              false,
                                                          autocorrect: false,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                "Confirm Password",
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        14),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
                                                            ),
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFF064E3B)),
                                                            ),
                                                          ),
                                                          controller:
                                                              confirmPasswordController,
                                                          validator: (input) =>
                                                              passwordController
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
                                  const Padding(
                                      padding: EdgeInsets.only(top: 20)),
                                  SizedBox(
                                    height: screenSize.height / 12.5,
                                    width: screenSize.width / 1.8,
                                    child: TextButton(
                                        onPressed: () =>
                                            {handleSubmit(context, user)},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF064E3B)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150.0),
                                                  side: const BorderSide(
                                                      color: Colors.white))),
                                        ),
                                        child: Text(
                                            "Save Changes".toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300))),
                                  ),
                                ],
                              ))
                        ])))));
  }
}
