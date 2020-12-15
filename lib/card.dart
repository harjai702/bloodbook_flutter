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
            height: flexible(context, 130),
           child: Column(
          children: [
             Text(widget.name.toString()),
             Text(widget.bgroup.toString()),
             Text(widget.adress.toString()),
             Text(widget.userId.toString()),
             Text(widget.date.toString()),
             Text(widget.phnnumber.toString()),
          ],
        ),
      ),),
    );
  }
}

