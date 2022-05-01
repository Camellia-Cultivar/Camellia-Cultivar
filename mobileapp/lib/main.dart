import 'package:camellia_cultivar/extensions/string_apis.dart';
import 'package:camellia_cultivar/homepage.dart';
import 'package:camellia_cultivar/layout.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/providers/user.dart';
import 'package:camellia_cultivar/registerpage.dart';
import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const LoginPage(),
    ),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camellia Cultivar',
      theme: ThemeData(
        primaryColor: const Color(0x00064e3b),
      ),
      home: const MyHomePage(title: ''),
      builder: (context, child) {
        return Layout(
          body: child as Widget,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _authError = false;
  final _formKey = GlobalKey<FormState>();

  void handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;

      User? user = await dbHelper.getUser(emailController.text);
      bool isAuth = user != null && user.password == passwordController.text;

      if (isAuth) {
        DateTime expiresIn = DateTime.now().add(const Duration(seconds: 60));
        final storage = new FlutterSecureStorage();
        await storage.write(key: "expiresIn", value: expiresIn.toString());

        setState(() => {
              _authError = false,
            });
        context.read<UserProvider>().setUser(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        setState(() => {
              _authError = true,
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkAuth() async {
    final storage = new FlutterSecureStorage();
    String expiresIn = await storage.read(key: "expiresIn") ?? "";

    if (expiresIn.isNotEmpty &&
        DateTime.now().compareTo(DateTime.parse(expiresIn)) < 0) {
      // bool isActiveBiometrics =
      //     (await storage.read(key: "isActiveBiometrics")) == "true";

      if (await LocalAuthApi.hasBiometrics()) {
        final isAuthenticated = await LocalAuthApi.authenticate();

        if (isAuthenticated) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6F7),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Form(
              key: _formKey,
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 600, minWidth: 300),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    // Column with all content
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 60, bottom: 30),
                                  width: 220,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                    ),
                                    controller: emailController,
                                    validator: (input) =>
                                        input != null && input.isValidEmail()
                                            ? null
                                            : "Invalid email",
                                  )),
                              SizedBox(
                                  width: 220,
                                  child: TextFormField(
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF064E3B)),
                                      ),
                                    ),
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required!';
                                      }

                                      return null;
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(
                              width: 260,
                              child: _authError == true
                                  ? const Text(
                                      "Email and Password do not match.",
                                      style: TextStyle(color: Colors.red))
                                  : null),
                          const Padding(padding: EdgeInsets.all(5)),
                          SizedBox(
                            height: 69,
                            width: 260,
                            child: TextButton(
                                onPressed: () => {
                                      handleSubmit(context),
                                    },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF064E3B)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(150.0),
                                          side: const BorderSide(
                                              color: Colors.white))),
                                ),
                                child: Text("Login".toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300))),
                          ),
                          SizedBox(
                            height: 69,
                            width: 260,
                            child: TextButton(
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage())),
                                    },
                                style: ButtonStyle(
                                  //backgroundColor: MaterialStateProperty.all(Color()),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(150.0),
                                          side: const BorderSide(
                                              color: Color(0xFF064E3B)))),
                                ),
                                child: Text("Register".toUpperCase(),
                                    style: const TextStyle(
                                        color: Color(0xFF064E3B),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300))),
                          ),
                        ]),
                  )),
            ),
            Positioned(
              top: -68,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF064E3B),
                ),
                height: 136,
                width: 136,
                child: const Icon(Icons.person_outlined,
                    color: Colors.white, size: 80),
              ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ),
    );
  }
}
