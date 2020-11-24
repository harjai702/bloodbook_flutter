import 'package:bloodbook/card.dart';
import 'package:bloodbook/loactionModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Stream<List<DocumentSnapshot>> stream;
  final geo = Geoflutterfire();
  List<GeoLocationInfo> listOfUser= new List<GeoLocationInfo>();
  var selectedDoc;
  bool vis=false;
  @override
  void initState(){
    super.initState();
    uuid=FirebaseAuth.instance.currentUser.uid;
    getvalue(uuid);
    updateposition();
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
    });
    stream.listen((List<DocumentSnapshot> documentList) {
      documentList.forEach((element) {
        GeoLocationInfo user;
        user=GeoLocationInfo.fromJson(element.data());
        listOfUser.add(user);
      });
      setState(() {
        listOfUser=listOfUser;
        vis=true;
      });
    });
    /*location.onLocationChanged.listen((LocationData currentLocation) {
      updateposition();
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
          child:Column(
            children: <Widget>[
              SizedBox(height: 40.0,),
              Center(
                child: Container(
                  child:Text('Hello World'),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.fromLTRB(250.0, 0.0, 0.0, 0.0),
                child:FloatingActionButton(
                  onPressed: (){
                    listOfUser.clear();
                    Navigator.of(context).pushNamed('/postpage');
                  },
                  elevation: 0.0,
                  backgroundColor: Colors.lightGreen,
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 400.0,
                width: 400.0,
                child: _postList(),
              ),
            ],
          ),
        )
    );
  }
  Widget _postList(){
    if(vis){
      return ListView.builder(
              itemCount: listOfUser.length,
              //padding: EdgeInsets.all(5.0),
              itemBuilder: (context,i){
                String address=listOfUser[i].address1.toString()+","+listOfUser[i].address2.toString()+","+listOfUser[i].city.toString()+","+listOfUser[i].state.toString();
                return new CardUi(
                  name: listOfUser[i].name,
                  bgroup: listOfUser[i].bgroup,
                  userId: listOfUser[i].usrid,
                  adress: address,
                  //adress: (listOfUser[i].address1.to+","+listOfUser[i].address2+","+listOfUser[i].address3+","+listOfUser[i].address4).toString(),
                );
              },
            );
    }
    else{
      return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color:Colors.grey,
            size:100.0,
          ),),);
    }
  }
}