import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
class UserManagement{
  storeNewUser(user,context,dispname){
    FirebaseFirestore.instance.collection('/users').add({
      'email':user.email,
      'uid':user.uid,
      'displayName': dispname,
    }).then((value){
      //
    }).catchError((e){
      print(e);
    });
  }
}