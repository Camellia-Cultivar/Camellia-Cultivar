import 'package:camellia_cultivar/api/api_service.dart';
import 'package:camellia_cultivar/login_page.dart';
import 'package:camellia_cultivar/model/user.dart';
import 'package:flutter/material.dart';
import "package:camellia_cultivar/extensions/string_apis.dart";
import 'package:camellia_cultivar/utils/auth.dart';

class FormFieldWidget extends StatelessWidget {
  FormFieldWidget(
      {required this.text,
      required this.width,
      required this.controller,
      this.enableSuggestions = true,
      this.validator,
      this.obscureText = false,
      this.autocorrect = true});

  final String text;
  final double width;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enableSuggestions;
  final bool obscureText;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: text,
                filled: true,
                fillColor: const Color(0x1FA4A4A4),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0x1FA4A4A4))),
              ),
              controller: controller,
              validator: validator,
              obscureText: obscureText,
              autocorrect: autocorrect,
              enableSuggestions: enableSuggestions,
            )));
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final api = APIService();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FocusNode focusEmail = FocusNode();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  // void handleSubmit() async {
  //   final dbHelper = DatabaseHelper.instance;
  //   User user = User(
  //     id: null as int,
  //     firstName: firstNameController.text,
  //     email: emailController.text,
  //     lastName: lastNameController.text,
  //     password: passwordController.text,
  //     reputation: 0,
  //   );

  //   try {
  //     User? existingUser = await dbHelper.getUser(user.email);

  //     if (existingUser != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content:
  //                 Text('Account already exists! Try with a different email.'),
  //             backgroundColor: Colors.red),
  //       );
  //       return;
  //     }

  //     int id = await dbHelper.insert("users", user.toJson());
  //     user.id = id;
  //   } catch (_) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text('Failed to create account. Please try again later!'),
  //           backgroundColor: Colors.red),
  //     );
  //     return;
  //   }

  //   await login(context, user);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //         content: Text("Account create successfuly."),
  //         backgroundColor: Colors.green),
  //   );
  // }

  void handleSubmit() async {
    //TODO: send registered password
    // var password = passwordController.text;

    // User user = User(
    //     id: null as int,
    //     firstName: firstNameController.text,
    //     email: emailController.text,
    //     lastName: lastNameController.text,
    //     password: passwordController.text,
    //     reputation: 0,
    //     profileImageUrl:
    //         "https://cdn.discordapp.com/attachments/958416677777854545/981241254778138664/unknown.png");
    Map<String, String> signup_user = {
      'profile_photo':
          "https://cdn.discordapp.com/attachments/958416677777854545/981241254778138664/unknown.png",
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };

    List<Object> response = await api.createUser(signup_user);
    // User? existingUser = await api.getUser(user.id);

    // if (existingUser != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content:
    //             Text('Account already exists! Try with a different email.'),
    //         backgroundColor: Colors.red),
    //   );
    //   return;
    // }

    // int uid = await api.createUser(user) as int;
    // user.id = uid;

    // await api.updatePassword(user.id, password);

    // await login(context, user);
    if (response[0] == 201) {
      showSnackBar("Account create successfuly.", Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else if (response[1] == "User already exists") {
      showSnackBar("Email already in use.", Colors.red);
    } else {
      showSnackBar(response[1].toString(), Colors.red);
    }
  }

  showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          height: screenSize.height / 1.2,
          width: screenSize.width / 1.2,
          child: Column(children: [
            Padding(
                padding:
                    EdgeInsets.only(top: 20, right: screenSize.width / 9.82),
                child: Wrap(
                  spacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    BackButton(
                      color: primaryColor,
                    ),
                    Text("Create Account",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: screenSize.height / 35,
                            fontWeight: FontWeight.w500))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: screenSize.height / 30,
                    right: screenSize.height / 20,
                    left: screenSize.height / 20),
                child: Column(
                  children: [
                    FormFieldWidget(
                      text: "First Name",
                      width: screenSize.width / 1.2,
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                    FormFieldWidget(
                        text: "Last Name",
                        width: screenSize.width / 1.2,
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        }),
                    FormFieldWidget(
                      text: "Email",
                      width: screenSize.width / 1.2,
                      controller: emailController,
                      validator: (input) =>
                          input != null && input.isValidEmail()
                              ? null
                              : "Invalid email",
                    ),
                    FormFieldWidget(
                      text: "Password",
                      width: screenSize.width / 1.2,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            confirmPasswordController.text.isNotEmpty) {
                          return 'Password is required!';
                        }
                        return null;
                      },
                    ),
                    FormFieldWidget(
                      text: "Confirm Password",
                      width: screenSize.width / 1.2,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: confirmPasswordController,
                      validator: (input) =>
                          passwordController.text.isNotEmpty &&
                                  passwordController.text != input
                              ? "Passwords don't match!"
                              : null,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text:
                                  'By registering, you are agreeing with our '),
                          TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.all(screenSize.height / 45)),
                    SizedBox(
                      height: screenSize.height / 12.5,
                      width: screenSize.width / 1.8,
                      child: TextButton(
                          onPressed: () => {handleSubmit()},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(150.0),
                                    side:
                                        const BorderSide(color: Colors.white))),
                          ),
                          child: Text("Register".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300))),
                    ),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
