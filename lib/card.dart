import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
var hello;
class CardUi extends StatefulWidget {
  String name,bgroup,adress,userId,date,phnnumber;
  CardUi({this.name,this.bgroup,this.adress,this.userId,this.date,this.phnnumber});
  @override
  _CardUiState createState() => _CardUiState();
}

class _CardUiState extends State<CardUi> {
  static const col=Color(0xFFF6B2C0);//contstant color declaration
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Card(
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 5 ,
          child:Container(
            height: flexible(context, 150),
           child: Column(
          children: [
            SizedBox(height: flexible(context, 10),),
            Row(
              children: <Widget>[
                SizedBox(width: flexible(context, 20),),
                Container(
                height: flexible(context, 40),
                width: flexible(context, 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(flexible(context, 75)),
                    color: col,
                  ),
                  child: Center(child: Text("AB-",style: TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(width: flexible(context, 15),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Mr. Harsh Harjai",style: TextStyle(color:col,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: flexible(context, 3),),
                    Text("(Blood Seeker Name)",style: TextStyle(color: col,fontSize: 10,fontStyle: FontStyle.italic),),
                  ],
                ),
              ],
            ),
             SizedBox(height: flexible(context, 13),),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 //SizedBox(width: flexible(context, ),),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text("Blood Seeker Phone Number",style: TextStyle(color: col,fontSize: flexible(context, 13)),),
                     SizedBox(height: flexible(context, 3),),
                     Text("7027028084",style: TextStyle(color:col,fontSize: 20,fontStyle: FontStyle.italic),),
                   ],
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     SizedBox(height: flexible(context, 5),),
                     Text("Address",style: TextStyle(color: col,fontSize: flexible(context, 13)),),
                     SizedBox(height: flexible(context, 3),),
                     Text("622,VPO Naharpur",style: TextStyle(color: col,fontSize: 13,fontStyle: FontStyle.italic),),
                     Text("135001,Haryana",style: TextStyle(color:col,fontSize: 13,fontStyle: FontStyle.italic),),
                   ],
                 ),
               ],
             ),
            SizedBox(height: flexible(context, 15),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: flexible(context, 130),),
                Text("Posted on 16 Dec at 01.00 AM",style: TextStyle(color: col,fontSize: 10.0,fontStyle: FontStyle.italic),),
              ],
            ),
            // Text(widget.name.toString()),
             //Text(widget.bgroup.toString()),
             //Text(widget.adress.toString()),
             //Text(widget.userId.toString()),
             //Text(widget.date.toString()),
            // Text(widget.phnnumber.toString()),
          ],
        ),
      ),),
    );
  }
}

