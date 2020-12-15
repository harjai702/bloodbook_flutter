import 'package:bloodbook/entrypage.dart';
import 'package:bloodbook/loginpage.dart';
import 'package:bloodbook/testpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'signuppage.dart';
import 'dart:async';
import 'feed2.dart';
import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginpage.dart';
import 'phnsignup.dart';
import 'post.dart';
import 'entrypage.dart';
import 'testpage2.dart';

String userID;
String password;
void main() async {
  runApp(MyApp());
Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  userID= await storage.read(key: 'userID');
  password=await storage.read(key: 'password');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenFlexibleWidget(
      child: Builder(
        builder:(BuildContext Context){
          return MaterialApp(
            home: MyHomePage(),
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              '/signup': (BuildContext context) => new SignupPage(),
              '/login': (BuildContext context) => new LoginPage(),
              '/phnsign': (BuildContext context) => new PhnSign(),
              '/feedpage': (BuildContext context) => new Feed2Page(),
              '/postpage': (BuildContext context) => new PostPage(),
              '/testpage': (BuildContext context) => new Testpage2(),
            }
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
        @override
        SplashScreenState createState() => SplashScreenState();
        }
        class SplashScreenState extends State<MyHomePage> {

          void getlogin(context){
            FirebaseAuth.instance.signInWithEmailAndPassword(email: userID, password: password);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => Feed2Page()
                )
            );

          }
        @override
        void initState() {
        super.initState();
        Timer(Duration(seconds: 3),
        ()=>(userID==null)?Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
                (context) => FirstPage()
            )
        ):getlogin(context),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child:
        Image(
          image: AssetImage('assets/images/logobapp.gif'),
        ),
      ),
    );
  }
}