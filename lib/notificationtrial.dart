import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class Notificationstate1 extends StatefulWidget {
  @override
  _Notificationstate1State createState() => new _Notificationstate1State();
}
class _Notificationstate1State extends State<Notificationstate1> with SingleTickerProviderStateMixin{
  final FirebaseMessaging _messaging=FirebaseMessaging();
  @override
  void initState(){
    super.initState();
    _messaging.getToken().then((token){
      print(token);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
       children: <Widget>[
         SizedBox(height: 30.0,),
         Text('Hello World'),
       ],
    );
     }
}