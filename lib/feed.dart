import 'package:flutter/material.dart';
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
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  void getLocation() async{
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
    await getaddress(_location.latitude,_location.longitude);
    setState(() {
      //address=location.currentAddress;
      lattitide=_location.latitude.toString();
      longitude=_location.longitude.toString();
      //address=adrs.currentAddress;
      //print(lattitide+" "+longitude);
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        getaddress(currentLocation.latitude, currentLocation.longitude);
       lattitide=currentLocation.latitude.toString();
       longitude=currentLocation.longitude.toString();
      });
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
            ],
          ),
        ),
      ),
    );
  }
}