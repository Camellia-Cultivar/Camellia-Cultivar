import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/editprofilepage.dart';
import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/model/user.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);


  void handleClick(BuildContext context, User user) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.delete("users", user.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    var json = {"profile_image": "https://i.imgflip.com/2/1975nj.jpg", "name": "Sherlock Holmes", "email":  "sherlockh@gmail.com", "password": "******", "reputation": "3000"};

    User? user = context.read<UserProvider>().user;

    if(user == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return const Scaffold();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFA4A4A4),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
          ),
          height: 770,
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 60, bottom: 20), 
                child: Wrap(
                  spacing: 40,
                  children: const [
                    BackButton(
                      color: Color(0xFF064E3B),
                    ),
                    Text("Profile", style: TextStyle(color: Color(0xFF064E3B), fontSize: 30, fontWeight: FontWeight.w500))
                  ],
                )
              ),
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
                padding: const EdgeInsets.only(right: 100, left: 100, top: 60),
                child: 
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person_outlined, 
                            color: Color(0xFF064E3B),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(user.name, style: const TextStyle(color: Color(0xFF064E3B)))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconData(0xf018, fontFamily: 'MaterialIcons'),
                            color: Color(0xFF064E3B),
                          ),
                          const Padding(padding: EdgeInsets.all(10)), 
                          Text(user.email, style: const TextStyle(color: Color(0xFF064E3B)))
                        ],
                      )
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Icon(
                            IconData(0xf3e2, fontFamily: 'MaterialIcons'), 
                            color: Color(0xFF064E3B),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text("0 reputation", style: const TextStyle(color: Color(0xFF064E3B)))
                        ],
                      )
                    ),
                    const Padding(padding: EdgeInsets.all(60)),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextButton(
                        onPressed: ()=>{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()))
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
                        child: Text("Edit".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextButton(
                        onPressed: () => {
                          context.read<UserProvider>().setUser(null),
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
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
                        child: Text("Log out".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                    ),
                      SizedBox(
                      height: 50,
                      width: 200,
                      child: TextButton(
                        onPressed: () => {
                         handleClick(context, user)
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
                        child: Text("Delete account".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                    ),
                  ],
                )
              )
            ]
          )
        )
      )
    );  
  }
}
