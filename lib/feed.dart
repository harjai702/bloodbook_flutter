import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'package:location/location.dart';
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => new _FeedPageState();
}
class _FeedPageState extends State<FeedPage> with SingleTickerProviderStateMixin{
  String address="";
  String lattitide="";
  String longitude="";
  var selectedDoc;
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  getvalue(String uuid) async{
    var exp=await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uuid).snapshots();
    exp.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          selectedDoc=element.id;
          //profilePicUrl=element.data()['photoUrl'];
          //profilePicUrl=element.id;
        });
        //print(profilePicUrl);
      });
    });
  }
  updateData(selectedDoc, newValues){
    FirebaseFirestore
        .instance.collection('users')
        .doc(selectedDoc)
        .update(newValues)
        .catchError((e){
      print(e);
    });
  }
  void getLocation() async{
    String uuid=FirebaseAuth.instance.currentUser.uid;
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    await getvalue(uuid);
    updateData(selectedDoc,{
      'lattitide': _location.latitude.toString(),
      'longitude': _location.longitude.toString()
    });
    await getaddress(_location.latitude,_location.longitude);
    setState(() {
      //address=location.currentAddress;
      lattitide=_location.latitude.toString();
      longitude=_location.longitude.toString();

      //address=adrs.currentAddress;
      //print(lattitide+" "+longitude);
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      /*setState(() {
        getaddress(currentLocation.latitude, currentLocation.longitude);
       lattitide=currentLocation.latitude.toString();
       longitude=currentLocation.longitude.toString();
      });*/
      getLocation();
    });
  }
  getaddress(double latitude,double longitude) async{
    Address adrs=Address(latitude,longitude);
    await adrs.getAddressFromLatLng();
    setState(() {
      address=adrs.currentAddress;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 160.0,),
              Text(lattitide+" "+longitude+" "+address),
              SizedBox(height: 30.0,),
              FlatButton(
                onPressed: (){
                  getLocation();
                },
                child:Container(
                  height: 50.0,
                  width: 70.0,
                  color: Colors.grey[300],
                  child: Text('Update Location',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}