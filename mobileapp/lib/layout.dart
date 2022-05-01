import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Layout extends StatelessWidget {
  final Widget body;

  Layout({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          body,
          // const ConnectivityNotification(),
        ],
      ),
    );
  }
}

class ConnectivityNotification extends StatefulWidget {
  const ConnectivityNotification({Key? key}) : super(key: key);

  @override
  State<ConnectivityNotification> createState() => _ConnectivityNotification();
}

class _ConnectivityNotification extends State<ConnectivityNotification> {
  bool _isConnected = true;

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (mounted) {
              setState(() {
                _isConnected = true;
              });
            }
            break;
          case InternetConnectionStatus.disconnected:
            if (mounted) {
              setState(() {
                _isConnected = false;
              });
            }
            break;
        }
      },
    );

    Widget alert = Container(
      alignment: Alignment.center,
      child: const Text("Please connect to an active internet connection",
          style: TextStyle(color: Colors.white)),
      color: Colors.red,
      height: 40,
    );

    return _isConnected == false
        ? Container(child: alert, alignment: Alignment.bottomCenter)
        : Container();
  }
}
