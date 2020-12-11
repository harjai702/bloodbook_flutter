import 'package:flutter/material.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 270.0,),
          Center(child: Text("BLOODBOOK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Color(0xFFE7AEBF)),)),
          Text("A life Giving App",style: TextStyle(fontFamily: "Pacifico",fontSize: 20.0,color: Color(0xFFF6B2C0)),),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFFF6B2C0),
              ),
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/login');
                },
                child: Container(
                  child: Center(child: Text("Existing User/Login",style: TextStyle(fontSize: 17.0,color: Colors.white,),)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xFFF6B2C0)),
                color: Colors.white,
              ),
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Container(
                  child: Center(child: Text("New User/Signup",style: TextStyle(fontSize: 17.0,color:Color(0xFFF6B2C0),),)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(75, 10, 75, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(75)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://user-images.githubusercontent.com/42409905/101822108-dc090a80-3b4e-11eb-90ae-bf66204ea21f.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(75)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://user-images.githubusercontent.com/42409905/101821518-11f9bf00-3b4e-11eb-9d87-040aadc945c8.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(75)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://user-images.githubusercontent.com/42409905/101821527-158d4600-3b4e-11eb-8e1d-d756767d7528.png"),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}