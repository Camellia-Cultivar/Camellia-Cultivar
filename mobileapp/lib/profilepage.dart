import 'package:camellia_cultivar/editprofilepage.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var json = {"profile_image": "https://i.imgflip.com/2/1975nj.jpg", "name": "Sherlock Holmes", "email":  "sherlockh@gmail.com", "password": "******", "reputation": "3000"};

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
                          Text(json["name"].toString(), style: const TextStyle(color: Color(0xFF064E3B)))
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
                          Text(json["email"].toString(), style: const TextStyle(color: Color(0xFF064E3B)))
                        ],
                      )
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconData(0xf052b, fontFamily: 'MaterialIcons'),
                            color: Color(0xFF064E3B),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(json["password"].toString(), style: const TextStyle(color: Color(0xFF064E3B)))
                        ],
                      )
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconData(0xf3e2, fontFamily: 'MaterialIcons'), 
                            color: Color(0xFF064E3B),
                          ),
                          const Padding(padding: EdgeInsets.all(10)),
                          Text(json["reputation"].toString() + " reputation", style: const TextStyle(color: Color(0xFF064E3B)))
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
