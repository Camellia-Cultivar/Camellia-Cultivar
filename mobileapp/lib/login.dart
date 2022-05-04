import 'package:camellia_cultivar/database/database_helper.dart';
import 'package:camellia_cultivar/extensions/string_apis.dart';
import 'package:camellia_cultivar/homepage.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:camellia_cultivar/registerpage.dart';
import 'package:camellia_cultivar/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _authError = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleSubmit(BuildContext context) async {
    setState(() => {
          _authError = false,
        });

    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;

      User? user;

      try {
        user = await dbHelper.getUser(emailController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to authenticate. Please try again!"),
              backgroundColor: Colors.red),
        );
        return;
      }

      bool isAuth = user != null && user.password == passwordController.text;

      if (isAuth) {
        await login(context, user);

        emailController.clear();
        passwordController.clear();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        setState(() => {
              _authError = true,
            });
      }
    }
  }

  void checkAuth() async {
    const storage = FlutterSecureStorage();
    String expiresIn = await storage.read(key: "expiresIn") ?? "";

    if (expiresIn.isNotEmpty &&
        DateTime.now().compareTo(DateTime.parse(expiresIn)) < 0) {
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
    var screenSize = MediaQuery.of(context).size;

    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F6F7),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Form(
              key: _formKey,
              child: Container(
                width: screenSize.width / 1.4,
                height: screenSize.height / 1.8,
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
                              padding:
                                  const EdgeInsets.only(top: 60, bottom: 30),
                              width: screenSize.width / 1.8,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                ),
                                controller: emailController,
                                validator: (input) =>
                                    input != null && input.isValidEmail()
                                        ? null
                                        : "Invalid email",
                              )),
                          SizedBox(
                              width: screenSize.width / 1.8,
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primaryColor),
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
                          width: screenSize.width / 1.8,
                          child: _authError == true
                              ? const Text("Email and Password do not match.",
                                  style: TextStyle(color: Colors.red))
                              : null),
                      const Padding(padding: EdgeInsets.all(5)),
                      SizedBox(
                        height: screenSize.height / 12.5,
                        width: screenSize.width / 1.8,
                        child: TextButton(
                            onPressed: () => {
                                  handleSubmit(context),
                                },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
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
                                    fontWeight: FontWeight.w300))),
                      ),
                      SizedBox(
                        height: screenSize.height / 12.5,
                        width: screenSize.width / 1.8,
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
                                      side: BorderSide(color: primaryColor))),
                            ),
                            child: Text("Register".toUpperCase(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w300))),
                      ),
                    ]),
              ),
            ),
            Positioned(
              top: -68,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                // height: 136,
                // width: 136,
                height: screenSize.height / 7,
                width: screenSize.width / 3,
                child: Icon(Icons.person_outlined,
                    color: Colors.white, size: screenSize.width / 7),
              ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ),
    );
  }
}
