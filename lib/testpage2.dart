import 'package:flutter/material.dart';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usermanagement.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/services.dart';
class Testpage2 extends StatefulWidget {
  @override
  _Testpage2State createState() => _Testpage2State();
}

class _Testpage2State extends State<Testpage2> {
  String _value;
  String _email;
  bool vis=true;
  String _password;
  String _name;
  String bgroup;
  String phnnumber;
  String age;
  String gender;
  String lattitide="";
  String longitude="";
  bool vis3=false;
  GeoFirePoint loc;
  final geo = Geoflutterfire();
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  getLocation() async{
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    GeoFirePoint center = geo.point(latitude: _location.latitude, longitude: _location.longitude);
    setState(() {
      loc=center;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(child: Text("          BloodBook",style: TextStyle(color:Color(0xFFF6B2C0),fontFamily: "Pacifico",fontSize: 30.0),)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dehaze,
              color: Color(0xFFF6B2C0),
            ),
            onPressed: () {
              // do something
            },
          ),
          SizedBox(width: 10.0,),
        ],
      ),
        backgroundColor: Colors.white,
    ),);
  }
}
