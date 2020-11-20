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
  var selectedDoc;
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
    double radius = 50;
    String field = 'position';
    var collectionReference = FirebaseFirestore.instance.collection('locations');
    setState(() {
      stream = geo.collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);
    });
    stream.listen((List<DocumentSnapshot> documentList) {
      print(documentList);
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
              Container(
                height: 400.0,
                width: 400.0,
                //child: _postList(),
              ),
            ],
          ),
        )
    );
  }
  Widget _postList(){
    if(stream!=null){
      return StreamBuilder(
        stream: stream,
          //future:fedata,
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              //padding: EdgeInsets.all(5.0),
              itemBuilder: (context,i){
                return new ListTile(
                  title: Text(snapshot.data.docs[i].data()['usrid']),
                );
              },
            );
          }
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