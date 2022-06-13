import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../home/homepage.dart';
import '../authentication/login_page.dart';

Future<void> login(BuildContext context, User user) async {
  context.read<UserProvider>().setUser(user);

  DateTime expiresIn = DateTime.now().add(const Duration(seconds: 30));

  final storage = new FlutterSecureStorage();
  await storage.write(key: "expiresIn", value: expiresIn.toString());

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomePage()));
}

Future<void> logout(BuildContext context, User user) async {
  Navigator.popUntil(context, (route) => route.isFirst);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));

  final storage = new FlutterSecureStorage();
  await storage.delete(key: "expiresIn");
}
