import 'dart:collection';

import 'package:bloodbook/card.dart';
import 'package:bloodbook/entrypage.dart';
import 'package:bloodbook/loactionModel.dart';
import 'package:bloodbook/post.dart';
import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'address.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'crud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
class Feed2Page extends StatefulWidget {
  @override
  _Feed2PageState createState() => new _Feed2PageState();
}
class _Feed2PageState extends State<Feed2Page> with SingleTickerProviderStateMixin {
  var uuid;
  static const color=Color(0xFFF6B2C0);
  String username;
  String phnnumber;
  Stream<List<DocumentSnapshot>> stream;
  final geo = Geoflutterfire();
  List<GeoLocationInfo> listOfUser= new List<GeoLocationInfo>();
  //LinkedHashSet<GeoLocationInfo> listOfUser2= new LinkedHashSet<GeoLocationInfo>();
  var selectedDoc;
  bool vis=false;
  @override
  void initState(){
    super.initState();
    uuid=FirebaseAuth.instance.currentUser.uid;
    getvalue(uuid);//gets the document id of users location to update the locstion
    getusername(uuid);//get the user information
    updateposition();//update the position and gets the radius posts
  }
  void getvalue(String uuid) async{
    var exp=await FirebaseFirestore.instance.collection('locations').where('usrid',isEqualTo: uuid).snapshots();
    await exp.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          selectedDoc=element.id;
        });
      });
    });
  }
  void getusername(String uuid) async{
    var exp=await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uuid).snapshots();
    await exp.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          username=element.data()['displayName'];
          phnnumber=element.data()['phonenumber'];
        });
      });
    });
  }
  void updateposition() async{
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    // print(selectedDoc+_location.toString());
    //GeoFirePoint geoFirePoint = geo.point(latitude: 30.0575475, longitude: 77.2820764);
    GeoFirePoint center = geo.point(latitude: _location.latitude, longitude: _location.longitude);
    //GeoPoint g=await new GeoPoint(_location.latitude,_location.longitude);
    //print(g);
    await FirebaseFirestore
        .instance.collection('locations').doc(selectedDoc)
        .update({'usrid':uuid,'position':center.data})
        .catchError((e){
      print(e);
    });
    double radius = 2;
    String field = 'position';
    var collectionReference = FirebaseFirestore.instance.collection('postdata');
    setState(() {
      stream = geo.collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);
      //listOfUser.clear();
      print("hello where....");
    });
    stream.listen((List<DocumentSnapshot> documentList) {
      setState(() {
        listOfUser.clear();
      });
      print("hello there....");
      documentList.forEach((element) {
        GeoLocationInfo user;
        user=GeoLocationInfo.fromJson(element.data());
        listOfUser.add(user);
      });
      setState(() {
        print("Hello here...");
        listOfUser=listOfUser;
        vis=true;
        listOfUser.sort((a, b) => b.date.compareTo(a.date));
      });
    });
    /*location.onLocationChanged.listen((LocationData currentLocation) {
      updateposition();
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Center(child: Text("          BloodBook",style: TextStyle(color:Color(0xFFF6B2C0),fontFamily: "Pacifico",fontSize: flexible(context, 30)),)),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color(0xFFF6B2C0),
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Color(0xFFF6B2C0),
                  ),
                  onPressed: ()async{
                    FirebaseAuth.instance.signOut();
                    final storage = FlutterSecureStorage();
                    await storage.deleteAll();
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return FirstPage();
                    }));
                  },
                ),
                SizedBox(width: 10.0,),
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: flexible(context, 10),),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          //listOfUser.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostPage(
                                  username: username,
                                  phnnumber:phnnumber,
                                )),
                          );
                        },
                        child: Container(
                          height: flexible(context, 40),
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFFF6B2C0)),
                          ),
                          child: Center(child: Text("Push a Request",style: TextStyle(
                              color: Colors.grey,
                              fontSize: flexible(context, 15)
                          ),)),
                        ),
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Location: ',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                          Text("Naharpur,135001,",style: TextStyle(color: Colors.grey),),
                          //Text('135001,',style: TextStyle(color: Colors.grey),),
                          Text('Haryana',style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: flexible(context, 10),),
                  SingleChildScrollView(
                    child: Container(
                      height: flexible(context, 550),
                      width: flexible(context, 400.0),
                      child: _postList(),
                    ),
                  ),
                ],
              ),
            )
        ),),
    );
  }
  Widget _postList(){
    if(vis){
      return ListView.builder(
        itemCount: listOfUser.length,
        //padding: EdgeInsets.all(5.0),
        itemBuilder: (context,i){
          String address=listOfUser.elementAt(i).address1.toString()+","+listOfUser.elementAt(i).address2.toString()+","+listOfUser.elementAt(i).city.toString()+","+listOfUser.elementAt(i).state.toString();
          return new CardUi(
            name: listOfUser.elementAt(i).name,
            bgroup: listOfUser.elementAt(i).bgroup,
            userId: listOfUser.elementAt(i).usrid,
            adress: address,
            date: listOfUser.elementAt(i).date,
            phnnumber:listOfUser.elementAt(i).phnnumber,
            //adress: (listOfUser[i].address1.to+","+listOfUser[i].address2+","+listOfUser[i].address3+","+listOfUser[i].address4).toString(),
          );
        },
      );
    }
    else if(listOfUser==null){
      return Text("No Requests");}
    else{
      return Scaffold(
        body: Center(
          child: new CircularProgressIndicator(
            backgroundColor: Colors.grey,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFE7AEBF))
            ,),
        ),
      );
    }
  }
}