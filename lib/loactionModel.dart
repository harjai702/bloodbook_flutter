import 'package:cloud_firestore/cloud_firestore.dart';

class GeoLocationInfo {
  String usrid;
  Position position;

  GeoLocationInfo({this.usrid, this.position});

  GeoLocationInfo.fromJson(Map<String, dynamic> json) {
    usrid = json['usrid'];
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usrid'] = this.usrid;
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
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