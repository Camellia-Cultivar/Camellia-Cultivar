import 'package:camellia_cultivar/homepage.dart';
import 'package:camellia_cultivar/local_auth_api.dart';
import 'package:camellia_cultivar/registerpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camellia Cultivar',
      theme: ThemeData(
        // primarySwatch: Colors.blueGrey,
        primaryColor: const Color(0x00064e3b),
      ),
      home: const MyHomePage(title: ''),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffA4A4A4),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)
              ),
              height: 600,
              width: 300,
              // Column with all content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Column with username and password fields
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 60, bottom: 30),
                        width: 220,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                        )
                      ),
                     const SizedBox(
                        width: 220,
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                        )
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  SizedBox(
                    height: 69,
                    width: 260,
                      child: TextButton(
                        onPressed: ()=>{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))
                        }, 
                        style:  ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF064E3B)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150.0),
                              side: const BorderSide(color: Colors.white)
                            )
                          ),
                        ),
                        child: Text("Login".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                  ),
                  SizedBox(
                    height: 69,
                    width: 260,
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterPage())),
                        }, 
                        style:  ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all(Color()),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150.0),
                              side: const BorderSide(color: Color(0xFF064E3B))
                            )
                          ),
                        ),
                        child: Text("Register".toUpperCase(), style: const TextStyle(color: Color(0xFF064E3B), fontSize: 20, fontWeight: FontWeight.w300))
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final isAuthenticated = await LocalAuthApi.authenticate();

                          if(isAuthenticated) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          }
                        },
                        child: const Text("Authenticate with Fingerprint", style: TextStyle(color: Color(0xFF064E3B), fontSize: 15))
                      ),
                      const Icon(
                        Icons.arrow_forward, 
                        color: Color(0xFF064E3B), 
                        size: 20
                      )
                    ]
                  )
                ]
              ),
            ),
            
            // TextButton(onPressed: () => {
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage())),
            // } , child: Text("Next Page")),
            Positioned(
              top: -68,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF064E3B),
                ),
                height: 136,
                width: 136,
                child: const Icon(
                  Icons.person_outlined, 
                  color: Colors.white, 
                  size: 80
                ),
            ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
