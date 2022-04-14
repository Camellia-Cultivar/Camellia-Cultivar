import 'package:flutter/material.dart';

import 'homepage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA4A4A4),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
          ),
          height: 770,
          width: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 40, bottom: 20), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BackButton(
                      color: Color(0xFF064E3B),
                    ),
                    Text("Create Account", style: TextStyle(color: Color(0xFF064E3B), fontSize: 30, fontWeight: FontWeight.w500))
                  ],
                )
              ),
              Padding(padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox( // <-- SEE HERE
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
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
                      )
                    )
                  ),
                  SizedBox( // <-- SEE HERE
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
                      )
                    )
                  ),
                  SizedBox( // <-- SEE HERE
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
                      )
                    )
                  ),
                  SizedBox( // <-- SEE HERE
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
                      )
                    )
                  ),
                  SizedBox( // <-- SEE HERE
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: const Color(0x1FA4A4A4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color:Color(0x1FA4A4A4) )
                          ),
                        ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))
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