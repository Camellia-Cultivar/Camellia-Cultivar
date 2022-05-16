import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/login.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      builder: (context, child) {
        return Layout(
          body: child as Widget,
        );
      },
    );
  }
}
