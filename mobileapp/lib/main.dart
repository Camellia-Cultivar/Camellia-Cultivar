import 'dart:io';

import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/authentication/login_page.dart';
import 'package:camellia_cultivar/new_specimen/new_specimen_page.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camellia Cultivar',
      theme: ThemeData(
        primaryColor: const Color(0xFF064E3B),
      ),
      home: const LoginPage(),
      builder: (context, child) {
        return Layout(
          body: child as Widget,
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
