import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Layout extends StatelessWidget {
  final Widget body;

  Layout({required this.body});

  bool _isFirstMount = true;

  @override
  Widget build(BuildContext context) {
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            {
              if (!_isFirstMount) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('You are back online!'),
                      backgroundColor: Colors.green),
                );
              }
              break;
            }
          case InternetConnectionStatus.disconnected:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text("Please connect to an active internet connection"),
                  backgroundColor: Colors.red),
            );
            break;
        }

        _isFirstMount = false;
      },
    );
    return Scaffold(body: body);
  }
}
