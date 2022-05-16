import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  State<Layout> createState() => _Layout();
}

class _Layout extends State<Layout> {
  bool _isFirstMount = true;
  bool _isOffline = false;

  final internetConnectionChecker = InternetConnectionChecker();

  @override
  Widget build(BuildContext context) {
    internetConnectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            {
              if (!_isFirstMount && _isOffline) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('You are back online!'),
                      backgroundColor: Colors.green),
                );
                setState(() {
                  _isOffline = false;
                });
              } else {
                setState(() {
                  _isFirstMount = false;
                });
              }
              break;
            }
          case InternetConnectionStatus.disconnected:
            {
              if (!_isFirstMount && !_isOffline) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          "Please connect to an active internet connection"),
                      backgroundColor: Colors.red),
                );
                setState(() {
                  _isOffline = true;
                });
              } else {
                setState(() {
                  _isFirstMount = false;
                });
              }
              break;
            }
        }
      },
    );

    return Scaffold(body: widget.body);
  }
}
