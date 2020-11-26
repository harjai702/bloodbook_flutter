import 'package:cloud_firestore/cloud_firestore.dart';

class GeoLocationInfo {
  String usrid;
  Position position;
  String address1;
  String address2;
  String name;
  String bgroup;
  String city;
  String state;
  String date;


  GeoLocationInfo({
    this.usrid,
    this.position,
    this.address2,
    this.bgroup,
    this.name,
    this.address1,
    this.city,
    this.state,
    this.date
  });

  GeoLocationInfo.fromJson(Map<String, dynamic> json) {
    usrid = json['usrid'];
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    name=json['name'];
    address2=json['address2'];
    address1=json['address1'];
    city=json['city'];
    state=json['state'];
    bgroup=json['bgroup'];
    date=json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usrid'] = this.usrid;
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
    data['name']=this.name;
    data['address1']=this.address1;
    data['address2']=this.address2;
    data['bgroup']=this.bgroup;
    data['city']=this.city;
    data['state']=this.state;
    data['date']=this.date;
    return data;
  }
}

class Position {
  String geohash;
  GeoPoint geopoint;

  Position({this.geohash, this.geopoint});

  Position.fromJson(Map<String, dynamic> json) {
    geohash = json['geohash'];
    geopoint = json['geopoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geohash'] = this.geohash;
    data['geopoint'] = this.geopoint;
    return data;
  }
}