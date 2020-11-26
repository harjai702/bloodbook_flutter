import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
class UserManagement{
  final geo = Geoflutterfire();
  GeoFirePoint loc;
  storeNewUser(user,context,dispname,center,age,gender,phnnumber,bgroup){
    loc=center;
    FirebaseFirestore.instance.collection('/users').add({
      'email':user.email,
      'uid':user.uid,
      'displayName': dispname,
      'age':age,
      'gender':gender,
      'phonenumber':phnnumber,
      'bgroup':bgroup,
    }).then((value){
      //
    }).catchError((e){
      print(e);
    });
    addlocation(user.uid,center);
  }
  void addlocation(String uuid,center) async{
    await FirebaseFirestore
        .instance.collection('locations')
        .add({'usrid':uuid,'position':center.data})
        .catchError((e){
      print(e);
    });
  }
}