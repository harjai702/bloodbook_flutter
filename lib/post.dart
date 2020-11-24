import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PostPage extends StatefulWidget {
  @override
  _MyPostPageState createState() => new _MyPostPageState();
}
class _MyPostPageState extends State<PostPage> with SingleTickerProviderStateMixin{
  String name;
  GeoFirePoint loc;
  final geo = Geoflutterfire();
  String phnnumber;
  String bgroup;
  String address="";
  String address2="";
  String city;
  String state;
  bool vis=true;
  void addpost(){
    setState(() {
      vis=false;
    });
    FirebaseFirestore.instance.collection('/postdata').add({
      'usrid':FirebaseAuth.instance.currentUser.uid,
      'name':name,
      'bgroup': bgroup,
      'address1':address,
      'address2':address2,
      'city':city,
      'state':state,
      'position':loc.data
    }).then((value){
      Navigator.pop(context);
    }).catchError((e){
      print(e);
    });
  }
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  void getLocation() async{
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    loc =geo.point(latitude: _location.latitude, longitude: _location.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0,),
              Visibility(
                visible: vis,
                child:Column(
                  children: <Widget>[
                    Text('Info',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          name=value;
                        });
                      },
                    ),//name
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'Contact number',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          phnnumber=value;
                        });
                      },
                    ), //phn number
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'Blood Group Needed',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          bgroup=value;
                        });
                      },
                    ),//blood group

                    SizedBox(height: 20.0,),
                    Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'House No., Building Name*',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          address=value;
                        });
                      },
                    ),//address1
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'Road Name, Area, Colony*',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          address2=value;
                        });
                      },
                    ),//address2
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'City*',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          city=value;
                        });
                      },
                    ),//address3
                    TextField(
                      decoration:InputDecoration(
                        labelText: 'State*',
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily:'Montserrat',
                            fontWeight:FontWeight.bold,
                            color:Colors.grey
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide:BorderSide(color:Colors.black),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          state=value;
                        });
                      },
                    ),//address4
                    SizedBox(height: 20.0,),
                    Container(
                      padding: EdgeInsets.fromLTRB( 20.0, 0.0, 20.0, 0.0),
                      width:  200.0,
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: FlatButton(
                        onPressed: (){
                          addpost();
                        },
                        child: Text('Post',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !vis,
                child:Center(
                  child: SpinKitDoubleBounce(
                    color:Colors.grey,
                    size:100.0,
                  ),),
              ),
            ],
          ),
    ),
    );
  }
}