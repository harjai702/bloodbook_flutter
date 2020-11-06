import 'package:flutter/material.dart';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usermanagement.dart';
class SignupPage extends StatefulWidget {
  @override
  _MySignupPageState createState() => new _MySignupPageState();
}
class _MySignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin{
  String _email;
  String _password;
  String _name;
  @override
  Widget build(BuildContext context) {
    return ScreenFlexibleWidget(
        child: Builder(
        builder:(BuildContext Context) {
        return new Scaffold(
          backgroundColor: Colors.white,
          body:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(flexible(context, 20.0), flexible(context, 0.0), flexible(context, 20.0), flexible(context, 74.0)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: flexible(context, 50.0),),
                      TextField(
                        decoration:InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontSize: 22.0,
                              fontFamily:'Montserrat',
                              fontWeight:FontWeight.bold,
                              color:Colors.grey
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide:BorderSide(color:Colors.green),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            _email=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 10.0),),
                      TextField(
                        decoration:InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontSize: 22.0,
                              fontFamily:'Montserrat',
                              fontWeight:FontWeight.bold,
                              color:Colors.grey
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide:BorderSide(color:Colors.green),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            _password=value;
                          });
                        },
                        obscureText:true,
                      ),
                      SizedBox(height: flexible(context, 10.0),),
                      TextField(
                        decoration:InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                              fontSize: 22.0,
                              fontFamily:'Montserrat',
                              fontWeight:FontWeight.bold,
                              color:Colors.grey
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide:BorderSide(color:Colors.green),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            _name=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 30.0),),
                      Container(
                        padding: EdgeInsets.fromLTRB(flexible(context, 20.0), 0.0, flexible(context, 20.0), 0.0),
                        width: flexible(context, 200.0),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(flexible(context, 40.0)),
                        ),
                        child: FlatButton(
                          child: Text('Signup',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                          onPressed: (){
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _email,
                                password: _password
                            ).then((signedInUser){
                              UserManagement().storeNewUser(signedInUser.user,context,_name);
                            })
                                .catchError((e){
                              print(e);
                            });
                          },
                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        },),);
  }
}