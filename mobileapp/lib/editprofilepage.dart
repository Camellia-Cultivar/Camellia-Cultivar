import 'package:camellia_cultivar/profilepage.dart';
import 'package:flutter/material.dart';

import 'navbar/botnavbar.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var json = {
      "profile_image": "https://i.imgflip.com/2/1975nj.jpg",
      "name": "Sherlock Holmes",
      "email": "sherlockh@gmail.com",
      "password": "******",
      "reputation": "3000"
    };

    var edit = {};

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFA4A4A4),
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              height: 770,
              width: 400,
              child: Column(children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 60, bottom: 20),
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
                      json["profile_image"].toString(),
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(right: 100, left: 100, top: 60),
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: json["name"].toString(),
                                      hintStyle: const TextStyle(fontSize: 14),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                    ),
                                    controller: nameController,
                                  )),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  IconData(0xf018, fontFamily: 'MaterialIcons'),
                                  color: Color(0xFF064E3B),
                                ),
                                const Padding(padding: EdgeInsets.all(10)),
                                SizedBox(
                                    width: 150,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: json["email"].toString(),
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF064E3B)),
                                        ),
                                        border: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF064E3B)),
                                        ),
                                      ),
                                      controller: emailController,
                                    )),
                              ],
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                                const Padding(padding: EdgeInsets.all(10)),
                                SizedBox(
                                    width: 150,
                                    child: TextField(
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: const InputDecoration(
                                        hintText: "New Password",
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
                                      controller: passwordController,
                                    )),
                              ],
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(right: 45)),
                                SizedBox(
                                    width: 150,
                                    child: TextField(
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: const InputDecoration(
                                        hintText: "Confirm Password",
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
                                      controller: confirmPasswordController,
                                    )),
                              ],
                            )),
                        const Padding(padding: EdgeInsets.all(30)),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                              onPressed: () => {
                                    edit["name"] = nameController.text,
                                    edit["email"] = emailController.text,
                                    if (passwordController.text ==
                                        confirmPasswordController.text)
                                      {
                                        edit["password"] =
                                            passwordController.text,
                                      },
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfilePage()))
                                  },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
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
              ]))),
      bottomNavigationBar: const BotNavbar(pageIndex: 3),
    );
  }
}
