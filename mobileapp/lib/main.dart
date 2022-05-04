import 'package:camellia_cultivar/extensions/string_apis.dart';
import 'dart:io';

import 'package:camellia_cultivar/homepage.dart';
import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/login.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/registerpage.dart';
import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:camellia_cultivar/utils/auth.dart';

void main() {
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
      // routes: {
      //   "/home": (context) => const HomePage(),
      // },
      builder: (context, child) {
        return Layout(
          body: child as Widget,
        );
      },
    );
  }
}
