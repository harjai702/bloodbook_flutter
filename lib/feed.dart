import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'package:location/location.dart';
import 'crud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => new _FeedPageState();
}
class _FeedPageState extends State<FeedPage> with SingleTickerProviderStateMixin{
  String address="abc";
  Stream feeddata;
  Future fedata;
  bool _selected=true;
  var now = new DateTime.now().toString();
  crudMethods crudObj=new crudMethods();
  String phnnumber;
  String pr="_spinweel()";
  String emailaddress;
  String uuid;
  String date;
  String time;
  double a;
  double b;
  String bloodGroup="A+";
  String name;
  String lattitide="";
  String longitude="";
  String distanceInMeters="";
  var selectedDoc;
  Future<bool> addDialog(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return SingleChildScrollView(
        child: AlertDialog(
          title:Text('Add Post', style:TextStyle(fontSize: 15.0)),
          content:Column(
            children:<Widget>[
              Row(
                children: <Widget>[
                  Text("Your Name: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),),
                  Text(name,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10.0),),
                ],
              ),
              SizedBox(height:5.0),
              Row(
                children: <Widget>[
                  Text("Your E-mail: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),),
                  Text(emailaddress,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10.0),),
                ],
              ),
              SizedBox(height:5.0),
              Row(
                children: <Widget>[
                  Text("Your Contact Number: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),),
                  Text(phnnumber,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10.0),),
                ],
              ),
              TextField(
                decoration: InputDecoration(hintText: 'BloodGroup needed'),
                onChanged: (value){
                  this.bloodGroup=value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child:Text('Add'),
              textColor: Colors.blue,
              onPressed:(){
                Navigator.of(context).pop();
                  Map<String,String> postdata={'datetime':this.now,'usrid':this.uuid,'name':this.name,'phnnumber':this.phnnumber,'emailadress':this.emailaddress,'blood':this.bloodGroup,};
                  crudObj.addData(postdata).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print(e);
                  });
              },
            ),
          ],
        ),
      );
        }
    );
  }
  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return SingleChildScrollView(
          child:AlertDialog(
            content:Text('Request Added'),
            title:Text('You will be contacted soon', style:TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed:(){
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
      );
        }
    );
  }
  @override
  void initState(){
    uuid=FirebaseAuth.instance.currentUser.uid;
    super.initState();
    getLocation();
  }
  getvalue(String uuid) async{
    var exp=await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uuid).snapshots();
    exp.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          name=element.data()['displayName'];
          phnnumber=element.data()['phnnumber'];
          emailaddress=element.data()['email'];
          selectedDoc=element.id;
        });
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
   /*await  crudObj.getData().then((results){
      setState((){
        feeddata = results;
        _selected=true;
      });
    });*/
   /*setState(() {
     _selected=false;
   });*/
   fedata=FirebaseFirestore.instance.collection('postData').get();
   setState(() {
     _selected=true;
   });
   Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    a=_location.latitude;
    b=_location.longitude;
    await getvalue(uuid);
    await updateData(selectedDoc,{
      'lattitide': a.toString(),
      'longitude': b.toString()
    });
    //await getaddress(_location.latitude,_location.longitude);
    setState(() {
      distanceInMeters = Geolocator.distanceBetween(a, b,30.167423,77.209290).toString();
      //address=location.currentAddress;
      lattitide=a.toString();
      longitude=b.toString();

      //address=adrs.currentAddress;
      //print(lattitide+" "+longitude);
    });
    /*location.onLocationChanged.listen((LocationData currentLocation) {
      getLocation();
    });*/
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
      body:SingleChildScrollView(
        child:Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0,),
            Text("Latitude: "+lattitide+", Longitude: "+longitude),
            SizedBox(height: 10.0,),
            Text("Distance: "+distanceInMeters),
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.fromLTRB(250.0, 0.0, 0.0, 0.0),
              child:FloatingActionButton(
                onPressed: (){
                  addDialog(context);
                },
                elevation: 0.0,
                backgroundColor: Colors.lightGreen,
                child: Icon(Icons.add),
              ),
            ),
            Visibility(
              visible:!_selected,
              child: Container(
                height: 400.0,
                width: 400.0,
                child: _spinweel(),
              ),
            ),
            Visibility(
              visible: _selected,
              child: Container(
                height: 400.0,
                width: 400.0,
                child: _postList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _spinweel(){
    return Scaffold(
      body: Center(
      child: SpinKitDoubleBounce(
      color:Colors.grey,
      size:100.0,
    ),),);
  }
  Widget _postList(){
    if(_selected&&fedata!=null){
      return FutureBuilder(
        //stream: feeddata,
          future:fedata,
          builder: (context, snapshot){
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              //padding: EdgeInsets.all(5.0),
              itemBuilder: (context,i){
                return new ListTile(
                  title: Text(snapshot.data.docs[i].data()['name']+" "+snapshot.data.docs[i].data()['phnnumber']),
                  subtitle: Text(snapshot.data.docs[i].data()['blood']+" "+snapshot.data.docs[i].data()['emailadress']),
                  /*onTap: (){
                    updateDialog(context, snapshot.data.docs[i].documentID);
                  },
                  onLongPress: (){
                    crudObj.deleteDate(snapshot.data.docs[i].documentID);
                  },*/
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