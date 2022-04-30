import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class RegisterPage extends StatefulWidget {

const RegisterPage({Key? key}) : super(key: key);


  @override 
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleSubmit() async {
    // TODO: ofuscate password
    final dbHelper = DatabaseHelper.instance;
    User user = User(id: null as int ,firstName: firstNameController.text, email:emailController.text, lastName: lastNameController.text, password: passwordController.text );
    
    int id = await dbHelper.insert("users", user.toMap());
    user.id = id;

    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA4A4A4),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
          ),
          height: 770,
          width: 370,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 40, bottom: 20), 
                child: Wrap(
                  spacing: 20,
                  children: const [
                    BackButton(
                      color: Color(0xFF064E3B),
                    ),
                    Text("Create Account", style: TextStyle(color: Color(0xFF064E3B), fontSize: 30, fontWeight: FontWeight.w500))
                  ],
                )
              ),
              Padding(padding: const EdgeInsets.all(60),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "First Name",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4))
                          ),
                        ),
                        controller: firstNameController,
                      )
                    )
                  ),
                  SizedBox( 
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
                        controller: lastNameController,
                      )
                    )
                  ),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
                        controller: emailController,
                      )
                    )
                  ),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
                        controller: passwordController,
                      )
                    )
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'By registering, you are agreeing with our '),
                        TextSpan(text: 'Terms and Conditions', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff064E3B))),
                      ],
                    ),
                    textAlign: TextAlign.center,
                 ),
                 const Padding(padding: EdgeInsets.all(30)),
                  SizedBox(
                    height: 69,
                    width: 260,
                      child: TextButton(
                        onPressed: ()=>{
                          handleSubmit(),
                        }, 
                        style:  ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF064E3B)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150.0),
                              side: const BorderSide(color: Colors.white)
                            )
                          ),
                        ),
                        child: Text("Register".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                  ),
                ],
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}