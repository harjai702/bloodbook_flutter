import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class LoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => new _MyLoginPageState();
}
class _MyLoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  /*void adduser() async{
    GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
    //GeoPoint g=await new GeoPoint(_location.latitude,_location.longitude);
    //print(g);
    await FirebaseFirestore
        .instance.collection('locations')
        .add({'usrid':uuid,'position':center.data})
        .catchError((e){
      print(e);
    });
  }*/
  String _email="har123@gmail.com";
  String _password="harjai702";
  String uuid="helloharsh";
  double latitude=30.055126;
  double longitude=77.259419;
  bool vis=true;
  final geo = Geoflutterfire();
@override
Widget build(BuildContext context) {
  return SafeArea(
    child:Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Opacity(
              opacity: 1.0,
              child: ClipPath(
                clipper: WaveClipperOne(),
                child: Opacity(opacity: 0.7,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6B2C0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child:  Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png')
                                )
                            ),
                          ),),
                        Positioned(
                            left: 140,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/light-2.png')
                                  )
                              ),
                            )),
                        Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child:  Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/clock.png')
                                  )
                              ),
                            )),
                        Positioned(
                          top: 240.0,
                          left:30.0,
                          child: Text('BloodBook',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 40.0),),
                        ),
                        Positioned(
                          top: 300.0,
                          left:30.0,
                          child: Text('Login Here...',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 30.0),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(30.0),
              child:Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(20, 21, 24, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10)
                      )
                    ]
                  //#FFECEE
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[100]))
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color:Colors.grey[500]),
                        ),
                        onChanged: (value){
                          setState(() {
                            _email=value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color:Colors.grey[500]),
                        ),
                        onChanged: (value){
                          setState(() {
                            _password=value;
                          });
                        },
                        obscureText:true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.0,),
            Visibility(
              visible: vis,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFF6B2C0),
                  ),
                  child:FlatButton(
                    onPressed: (){
                      setState(() {
                        vis=false;
                      });
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
                          .then((FutureOr user){
                        Navigator.of(context).pushReplacementNamed('/feedpage');
                      })
                          .catchError((e){
                        print(e);
                      });
                    },
                    child: Opacity(
                      opacity: 1.0,
                      child: Container(
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !vis,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFF6B2C0),
                  ),
                  child:FlatButton(
                    onPressed: (){

                    },
                    child: Container(
                      child: Center(
                        child: new CircularProgressIndicator(backgroundColor: Colors.white,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFF6B2C0)),),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0,),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/testpage');
                },
                child: Text('Forget Password?',style: TextStyle(color: Color(0xFFF6B2C0)),),
              ),
            ),
          ],
        ),
      ),
    ),
  ),);
}
}
