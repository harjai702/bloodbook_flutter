import 'package:flutter/material.dart';
var hello;
class CardUi extends StatefulWidget {
  String name,bgroup,adress,userId,date;
  CardUi({this.name,this.bgroup,this.adress,this.userId,this.date});
  @override
  _CardUiState createState() => _CardUiState();
}

class _CardUiState extends State<CardUi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           Text(widget.name.toString()),
           Text(widget.bgroup.toString()),
           Text(widget.adress.toString()),
           Text(widget.userId.toString()),
           Text(widget.date.toString()),

        ],
      ),
    );
  }
}

