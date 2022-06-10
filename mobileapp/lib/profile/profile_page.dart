import 'package:camellia_cultivar/cultivar_page.dart';
import 'package:camellia_cultivar/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/utils/auth.dart';
import '../api/api_service.dart';
import '../navbar/botnavbar.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            icon,
            const Padding(padding: EdgeInsets.all(10)),
            Text(text, style: TextStyle(color: primaryColor))
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
  final api = APIService();

  // void handleDelete(BuildContext context, User user) async {
  //   final dbHelper = DatabaseHelper.instance;

  //   try {
  //     await dbHelper.delete("users", user.id);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text('Failed delete account!'),
  //           backgroundColor: Colors.red),
  //     );
  //     return;
  //   }

  //   await logout(
  //     context,
  //     user,
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //         content: Text('Sucessfully deletet account!'),
  //         backgroundColor: Colors.green),
  //   );
  // }
  bool one_call = false;

  Future<void> getUser(BuildContext context, User? user) async {
    if (user != null) {
      User? updated_user = await api.getUser(user.id);
      if (updated_user != null) {
        context.read<UserProvider>().setUser(updated_user);
        one_call = true;
      }
    }
  }

  void setOne_callFalse() {
    one_call = false;
  }

  void handleDelete(BuildContext context, User user) async {
    try {
      await api.deleteUser(user.id);
    } on Exception catch (_, e) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Sucessfully deletet account!'),
          backgroundColor: Colors.green),
    );
  }

  void handleLogout(BuildContext context, User user) async {
    await logout(context, user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Logged out from your account!'),
          backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    User? user = context.watch<UserProvider>().user;
    if (!one_call) {
      getUser(context, user);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6F7),
      body: Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  screenSize.width / 15.7,
                  screenSize.height / 20.6,
                  screenSize.width / 15.7,
                  screenSize.height / 20.6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: screenSize.height / 35,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
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
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[100],
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.network(
                                          user!.profileImage,
                                        )),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserDetailWidget(
                                    text: user.name != null ? user.name : "",
                                    icon: Icon(
                                      Icons.person_outlined,
                                      color: primaryColor,
                                    )),
                                UserDetailWidget(
                                    icon: Icon(
                                      const IconData(0xf018,
                                          fontFamily: 'MaterialIcons'),
                                      color: primaryColor,
                                    ),
                                    text: user.email != null ? user.email : ""),
                                UserDetailWidget(
                                  icon: Icon(
                                    const IconData(0xf3e2,
                                        fontFamily: 'MaterialIcons'),
                                    color: primaryColor,
                                  ),
                                  text: user.reputation != null
                                      ? '${user.reputation} reputation'
                                      : "",
                                )
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
                            //         activeColor: const primaryColor,
                            //         activeTrackColor: const Color(0x6F064E3B),
                            //         inactiveThumbColor: const primaryColor,
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
                                            setOne_callFalse(),
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        //const EditProfilePage()))
                                                        const EditProfilePage()))
                                          },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        150.0),
                                                side: BorderSide(
                                                    color: primaryColor))),
                                      ),
                                      child: Text("Edit".toUpperCase(),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w300))),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  height: screenSize.height / 12.5,
                                  width: screenSize.width / 1.8,
                                  child: TextButton(
                                      onPressed: () =>
                                          handleLogout(context, user as User),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                primaryColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        150.0),
                                                side: BorderSide(
                                                    color: primaryColor))),
                                      ),
                                      child: Text("Log out".toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300))),
                                )),
                            // Padding(
                            //     padding: const EdgeInsets.only(bottom: 20),
                            //     child: SizedBox(
                            //       height: screenSize.height / 12.5,
                            //       width: screenSize.width / 1.8,
                            //       child: TextButton(
                            //           onPressed: () =>
                            //               handleDelete(context, user as User),
                            //           style: ButtonStyle(
                            //             backgroundColor:
                            //                 MaterialStateProperty.all(
                            //                     Colors.red),
                            //             shape: MaterialStateProperty.all<
                            //                     RoundedRectangleBorder>(
                            //                 RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             150.0),
                            //                     side: const BorderSide(
                            //                         color: Colors.red))),
                            //           ),
                            //           child: Text(
                            //               "Delete account".toUpperCase(),
                            //               style: const TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.w300))),
                            //     )),
                          ],
                        ))
                  ]))),
      bottomNavigationBar: const BotNavbar(pageIndex: 3),
    );
  }
}
