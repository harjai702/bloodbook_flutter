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
    return Container(
      child:Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child:Container(
          height: 130,
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20),
           boxShadow: [
             BoxShadow(
                 color: Colors.grey,
                 blurRadius: 0.0,/*
                 offset: Offset(20, 30)*/
             )
           ],
         ),
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
    ),),);
  }
}

