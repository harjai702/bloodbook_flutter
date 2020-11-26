import 'package:flutter/material.dart';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usermanagement.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
class SignupPage extends StatefulWidget {
  @override
  _MySignupPageState createState() => new _MySignupPageState();
}
class _MySignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin{
  String _email;
  bool vis=true;
  String _password;
  String _name;
  String bgroup;
  String phnnumber;
  String age;
  String gender;
  String lattitide="";
  String longitude="";
  bool vis3=false;
  GeoFirePoint loc;
  final geo = Geoflutterfire();
  @override
  void initState(){
    super.initState();
    getLocation();
  }
  getLocation() async{
    Location location=new Location();
    LocationData _location;
    _location = await location.getLocation();
   GeoFirePoint center = geo.point(latitude: _location.latitude, longitude: _location.longitude);
    setState(() {
      loc=center;
    });
  }
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
                  child:Column(
                    children: <Widget>[
                      SizedBox(height: flexible(context, 50.0),),
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'E-mail *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Password *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Full Name *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                      SizedBox(height: flexible(context, 10.0),),
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Your Blood Group *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                            bgroup=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 10.0),),
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Your Contact Number *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                            phnnumber=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 10.0),),
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Age *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                            age=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 10.0),),
                      TextFormField(
                        decoration:InputDecoration(
                          labelText: 'Gender *',
                          labelStyle: TextStyle(
                              fontSize: 18.0,
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
                            gender=value;
                          });
                        },
                      ),
                      SizedBox(height: flexible(context, 30.0),),
                      Visibility(
                        visible: !vis,
                        child: Container(
                          padding: EdgeInsets.fromLTRB( 20.0, 0.0, 20.0, 0.0),
                          width:  200.0,
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: FlatButton(
                            onPressed: (){
                            },
                            child: new CircularProgressIndicator(backgroundColor: Colors.white,valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: vis3,
                        child:Text('Please fill all the required fields',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                      ),
                      Visibility(
                        visible: vis,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(flexible(context, 20.0), 0.0, flexible(context, 20.0), 0.0),
                          width: flexible(context, 200.0),
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(flexible(context, 40.0)),
                          ),
                          child: FlatButton(
                            child: Text('Signup',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                            onPressed: (){
                              if(_name==null||_email==null||_password==null||bgroup==null||phnnumber==null||age==null||gender==null){
                                setState(() {
                                  vis3=true;
                                });
                                Future.delayed(const Duration(milliseconds: 3000), () {
                                  setState(() {
                                    vis3=false;
                                  });
                                });
                              }
                              else{
                                setState(() {
                                  vis=false;
                                });
                                FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: _email,
                                    password: _password
                                ).then((signedInUser){
                                  UserManagement().storeNewUser(signedInUser.user,context,_name,loc,age,gender,phnnumber,bgroup);
                                  Navigator.of(context).pushNamed('/feedpage');
                                })
                                    .catchError((e){
                                  print(e);
                                });
                              }
                            },
                          ),

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