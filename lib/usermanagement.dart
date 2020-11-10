import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
class UserManagement{
  storeNewUser(user,context,dispname,lattitude,longitude){
    FirebaseFirestore.instance.collection('/users').add({
      'email':user.email,
      'uid':user.uid,
      'displayName': dispname,
      'lattitude': lattitude,
      'longitude': longitude,
    }).then((value){
      //
    }).catchError((e){
      print(e);
    });
  }
}