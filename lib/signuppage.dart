import 'package:flutter/material.dart';
import 'package:flexible/flexible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usermanagement.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/services.dart';
class SignupPage extends StatefulWidget {
  @override
  _MySignupPageState createState() => new _MySignupPageState();
}
class _MySignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin{
  String _value;
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
    return SafeArea(
      child:Scaffold(
      body:SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(50, 70, 50, 0),
              child: ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: 240.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: Color(0xFFE7AEBF),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 105, 30, 0),
                        child: Text("BloodBook",style: TextStyle(color:Colors.white,fontStyle: FontStyle.italic,fontSize: 30.0),),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 2, 30, 0),
                        child: Text("Signup",style: TextStyle(color:Colors.white,fontFamily: "Pacifico",fontSize: 30.0),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 13, 48, 0),
              child: Row(
                children: <Widget>[
                  Text("Note: Fields marked with ",style: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: FontWeight.bold),),
                  Text("* ",style: TextStyle(fontSize: 11,color: Colors.red,fontWeight: FontWeight.bold),),
                  Text("are compulsory to fill.",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.grey,),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child:Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Full Name *",
                        hintStyle: TextStyle(color:Colors.grey[500]),
                      ),
                      onChanged: (value){
                        setState(() {
                          _name=value;

                        });
                      },
                    ),
                  ),//name
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email *",
                        hintStyle: TextStyle(color:Colors.grey[500]),
                      ),
                      onChanged: (value){
                        setState(() {
                          _email=value;
                        });
                      },
                    ),
                  ),//email
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password *",
                        hintStyle: TextStyle(color:Colors.grey[500]),
                      ),
                      onChanged: (value){
                        setState(() {
                          _password=value;
                        });
                      },
                    ),
                  ),//password
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 5, 90, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          child: Row(
                            children: <Widget>[
                              Text('AB+',style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                          value: 'one',
                        ),
                        DropdownMenuItem<String>(
                          child: Row(
                            children: <Widget>[
                              Text('B+',style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          value: 'B+',
                        ),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          bgroup = value;
                        });
                      },
                      hint: Text('Select your Blood Group *',style: TextStyle(color: Colors.grey),),
                      value: bgroup,

                    ),
                  ),//bloodgroup
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: TextField(
                      //maxLength: 10,
                      //maxLengthEnforced: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your Mobile Number *",
                        hintStyle: TextStyle(color:Colors.grey[500]),
                      ),
                      onChanged: (value){
                        setState(() {
                          phnnumber=value;
                        });
                      },
                    ),
                  ),//mobilenumber
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 5, 100, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          child: Row(
                            children: <Widget>[
                              Text('Male',style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                          value: 'Male',
                        ),
                        DropdownMenuItem<String>(
                          child: Row(
                            children: <Widget>[
                              Text('Female',style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          value: 'Female',
                        ),
                        DropdownMenuItem<String>(
                          child: Row(
                            children: <Widget>[
                              Text('Not Willing to disclose',style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          value: 'null',
                        ),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      hint: Text('Gender *                           ',style: TextStyle(color: Colors.grey),),
                      value: gender,

                    ),
                  ),//gender
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                    ),
                    child: TextField(
                      //maxLength: 10,
                      //maxLengthEnforced: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Age *",
                        hintStyle: TextStyle(color:Colors.grey[500]),
                      ),
                      onChanged: (value){
                        setState(() {
                          age=value;
                        });
                      },
                    ),
                  ),//age
                ],
              ),
            ),
            Visibility(
              visible: vis3,
              child:Text('Please fill all the required fields',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
            ),//error message
            Visibility(
              visible: vis,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE7AEBF),
                  ),
                  child: FlatButton(
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
                    child: Opacity(
                      opacity: 1.0,
                      child: Container(
                        child: Center(
                          child: Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ), //signup button
            Padding(
              padding: EdgeInsets.fromLTRB(30, 12, 30, 0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFF6B2C0)),
                  color: Colors.white,
                ),
                child:FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Container(
                      child: Center(child: Text("Back to Home Page",style: TextStyle(fontSize: 17.0,color:Color(0xFFF6B2C0),),)),
                    ),
                  ),
                ),//back button
              ),
            Visibility(
              visible:!vis,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE7AEBF),
                  ),
                  child: FlatButton(
                    onPressed: (){

                    },
                    child: Container(
                      child: Center(
                        child: new CircularProgressIndicator(backgroundColor: Colors.white,valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFE7AEBF)),),
                      ),
                    ),
                  ),
                ),
              ),
            ), //rounded revolver
            SizedBox(height: 20.0,),
          ],
        ),
      ),),);
  }
}