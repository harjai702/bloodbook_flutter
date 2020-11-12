import 'dart:async';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => new _MyLoginPageState();
}
class _MyLoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  String _email="harsh12@gmail.com";
  String _password="harjai702";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(child:Column(
        children: <Widget>[
          SizedBox(height: flexible(context, 37.0),),
          Text('Login Here..',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            fontSize: 40.0
          ),
          ),
          Container(
           padding: EdgeInsets.fromLTRB(flexible(context, 20.0), flexible(context, 0.0), flexible(context, 20.0), flexible(context, 74.0)),
            child: Column(
              children: <Widget>[
                SizedBox(height: flexible(context, 50.0,),),
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
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily:'Montserrat',
                        fontSize: 22.0,
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
                  //obscureText:true,
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
                    onPressed: (){
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
                          .then((FutureOr user){
                        Navigator.of(context).pushReplacementNamed('/feedpage');
                      })
                          .catchError((e){
                        print(e);
                      });
                    },
                    child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                  ),

                ),
                SizedBox(height: flexible(context, 20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Rockit ?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child:Text('Register',
                        style:TextStyle(
                          color:Colors.red[900],
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration:TextDecoration.underline,
                        ),
                      ),
                    ),
                    //SizedBox(width: 20.0,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('/phnsign');
                      },
                      child:Text('Phone Register',
                        style:TextStyle(
                          color:Colors.red[900],
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration:TextDecoration.underline,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('/feedpage');
                      },
                      child:Text('feed page',
                        style:TextStyle(
                          color:Colors.red[900],
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration:TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: flexible(context, 200.0),
          width: flexible(context, 500.0),
          child:Image(
              image: AssetImage('assets/images/1st.jpg'),
              fit: BoxFit.fill,
            ),),
          ],
      ),
    ),);
  }
}