import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}
class _ResetPassState extends State<ResetPass> {
  String email;
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: ("Enter the email id"),
                ),
                onChanged:(value){
                  email=value;
                },
              ),
            ),
            FlatButton(
              onPressed: (){
                resetPassword(email);
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
