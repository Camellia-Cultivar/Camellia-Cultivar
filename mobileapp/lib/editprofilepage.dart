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

    @override
    void dispose() {
      firstNameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    }

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
                    height: 770,
                    width: 400,
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 30, right: 60, bottom: 20),
                          child: Wrap(
                            spacing: 40,
                            children: const [
                              BackButton(
                                color: Color(0xFF064E3B),
                              ),
                              Text("Edit Profile",
                                  style: TextStyle(
                                      color: Color(0xFF064E3B),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                      SizedBox(
                        width: 136,
                        height: 136,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90.0),
                          child: Image.network(
                            "https://i.imgflip.com/2/1975nj.jpg",
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 100, left: 100, top: 60),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.person_outlined,
                                      color: Color(0xFF064E3B),
                                    ),
                                    const Padding(padding: EdgeInsets.all(10)),
                                    SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(fontSize: 14),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF064E3B)),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF064E3B)),
                                            ),
                                          ),
                                          controller: firstNameController,
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
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(right: 45)),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                            ),
                                            controller: lastNameController,
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
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        IconData(0xf018,
                                            fontFamily: 'MaterialIcons'),
                                        color: Color(0xFF064E3B),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                            ),
                                            controller: emailController,
                                            validator: (input) =>
                                                input != null &&
                                                        input.isValidEmail()
                                                    ? null
                                                    : "Invalid email",
                                          )),
                                    ],
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        IconData(0xf052b,
                                            fontFamily: 'MaterialIcons'),
                                        color: Color(0xFF064E3B),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(10)),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            obscureText: true,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            decoration: const InputDecoration(
                                              hintText: "New Password",
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                            ),
                                            controller: passwordController,
                                            validator: (value) {
                                              if ((value == null ||
                                                      value.isEmpty) &&
                                                  confirmPasswordController
                                                      .text.isNotEmpty) {
                                                return 'Password is required!';
                                              }
                                              return null;
                                            },
                                          )),
                                    ],
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(right: 45)),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            obscureText: true,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            decoration: const InputDecoration(
                                              hintText: "Confirm Password",
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF064E3B)),
                                              ),
                                            ),
                                            controller:
                                                confirmPasswordController,
                                            validator: (input) =>
                                                passwordController
                                                            .text.isNotEmpty &&
                                                        passwordController
                                                                .text ==
                                                            input
                                                    ? null
                                                    : "Passwords don't match!",
                                          )),
                                    ],
                                  )),
                              const Padding(padding: EdgeInsets.all(30)),
                              SizedBox(
                                height: 50,
                                width: 200,
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
                                                  BorderRadius.circular(150.0),
                                              side: const BorderSide(
                                                  color: Colors.white))),
                                    ),
                                    child: Text("Save Changes".toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300))),
                              ),
                            ],
                          ))
                    ])))));
  }
}
