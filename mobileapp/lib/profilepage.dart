import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/editprofilepage.dart';
import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/utils/auth.dart';

class UserDetailWidget extends StatelessWidget {
  UserDetailWidget({required Icon this.icon, required String this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            icon,
            const Padding(padding: EdgeInsets.all(10)),
            Text(text, style: const TextStyle(color: Color(0xFF064E3B)))
          ],
        ));
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  bool _isActiveBiometrics = false;
  bool _isBiometricsAvailable = false;

  @override
  void initState() {
    super.initState();
    // checkBiometrics();
    // checkBiometricsAvailability();
  }

  @override
  void dispose() async {
    super.dispose();
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool('isActiveBiometrics', _isActiveBiometrics);

    // final storage = new FlutterSecureStorage();
    // await storage.write(
    //     key: "isActiveBiometrics", value: _isActiveBiometrics.toString());
  }

  // void checkBiometrics() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // bool isActiveBiometrics = prefs.getBool('isActiveBiometrics') ?? false;

  //   final storage = new FlutterSecureStorage();
  //   bool isActiveBiometrics =
  //       (await storage.read(key: "isActiveBiometrics")) == "true";

  //   setState(() {
  //     _isActiveBiometrics = isActiveBiometrics;
  //   });
  // }

  // void checkBiometricsAvailability() async {
  //   _isBiometricsAvailable = await LocalAuthApi.hasBiometrics();
  // }

  void handleDelete(BuildContext context, User user) async {
    final dbHelper = DatabaseHelper.instance;

    try {
      await dbHelper.delete("users", user.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed delete account!'),
            backgroundColor: Colors.red),
      );
      return;
    }

    await logout(
      context,
      user,
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void handleLogout(BuildContext context, User user) async {
    await logout(context, user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Logged out from your account!'),
          backgroundColor: Colors.green),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    User? user = context.watch<UserProvider>().user;

    if (user == null) {
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return const Scaffold();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF5F6F7),
        body: Center(
            child: Container(
                height: screenSize.height / 1.2,
                width: screenSize.width / 1.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
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
                              Text("Profile",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: screenSize.height / 8,
                                    width: screenSize.width / 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90.0),
                                      child: Image.network(
                                        "https://i.imgflip.com/2/1975nj.jpg",
                                      ),
                                    ),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UserDetailWidget(
                                      text: user.name,
                                      icon: const Icon(
                                        Icons.person_outlined,
                                        color: Color(0xFF064E3B),
                                      )),
                                  UserDetailWidget(
                                      icon: const Icon(
                                        IconData(0xf018,
                                            fontFamily: 'MaterialIcons'),
                                        color: Color(0xFF064E3B),
                                      ),
                                      text: user.email),
                                  UserDetailWidget(
                                      icon: const Icon(
                                        IconData(0xf3e2,
                                            fontFamily: 'MaterialIcons'),
                                        color: Color(0xFF064E3B),
                                      ),
                                      text: '${user.reputation} reputation'),
                                ],
                              ),
                              // SizedBox(
                              //     height: 40,
                              //     child: Row(children: [
                              //       Switch(
                              //         onChanged: _isBiometricsAvailable
                              //             ? (bool checked) => {
                              //                   setState(() {
                              //                     _isActiveBiometrics = checked;
                              //                   })
                              //                 }
                              //             : null,
                              //         value: _isActiveBiometrics,
                              //         activeColor: const Color(0xFF064E3B),
                              //         activeTrackColor: const Color(0x6F064E3B),
                              //         inactiveThumbColor: const Color(0xFF064E3B),
                              //         inactiveTrackColor: Color(0xFFF5F6F7),
                              //       ),
                              //       const Text("Authenticate with Biometrics")
                              //     ])),
                              const Padding(padding: EdgeInsets.all(10)),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: screenSize.height / 12.5,
                                    width: screenSize.width / 1.8,
                                    child: TextButton(
                                        onPressed: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EditProfilePage()))
                                            },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150.0),
                                                  side: const BorderSide(
                                                      color:
                                                          Color(0xFF064E3B)))),
                                        ),
                                        child: Text("Edit".toUpperCase(),
                                            style: const TextStyle(
                                                color: Color(0xFF064E3B),
                                                fontWeight: FontWeight.w300))),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: screenSize.height / 12.5,
                                    width: screenSize.width / 1.8,
                                    child: TextButton(
                                        onPressed: () =>
                                            handleLogout(context, user),
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
                                                      color:
                                                          Color(0xFF064E3B)))),
                                        ),
                                        child: Text("Log out".toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300))),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: screenSize.height / 12.5,
                                    width: screenSize.width / 1.8,
                                    child: TextButton(
                                        onPressed: () =>
                                            handleDelete(context, user),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150.0),
                                                  side: const BorderSide(
                                                      color: Colors.red))),
                                        ),
                                        child: Text(
                                            "Delete account".toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300))),
                                  )),
                            ],
                          ))
                    ]))));
  }
}
