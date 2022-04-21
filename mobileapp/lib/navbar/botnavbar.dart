import 'package:flutter/material.dart';

import '../camera.dart';
import '../flower_icon.dart';
import '../homepage.dart';
import 'gbutton.dart';
import 'gnav.dart';

class BotNavbar extends StatefulWidget {
  const BotNavbar({Key? key, required this.pageIndex}) : super(key: key);

  final int pageIndex; // 0 (New specimen), 1 (Home), 2 (Quiz), 3 (Profile)

  @override
  _BotNavBar createState() => _BotNavBar();
}

class _BotNavBar extends State<BotNavbar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.pageIndex;
    return /*Align(
        alignment: FractionalOffset.center,
        child:*/
        Stack(
      fit: StackFit.passthrough,
      // alignment: Alignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: Container(
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(150)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Color(0xFF064E3B),
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.grey[100]!,
                    color: Colors.black,
                    tabs: const [
                      GButton(
                        icon: FlowerIcon.new_specimen3,
                        text: 'New ID',
                      ),
                      GButton(
                        icon: Icons.home_rounded,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.list_rounded,
                        text: 'Quiz',
                      ),
                      GButton(
                        icon: Icons.person_outline_rounded,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        if (index != _selectedIndex) {
                          _selectedIndex = index;
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CameraPage()));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage(
                                            title: '',
                                          )));
                              break;
                            case 2:
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const CameraPage()));
                              break;
                            case 3:
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const CameraPage()));
                              break;
                            default:
                              print('Not a valid tab index');
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
            ))
      ],
    );
    // );
  }
}
