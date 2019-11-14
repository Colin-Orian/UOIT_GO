import 'package:flutter/material.dart';

class Objective extends StatelessWidget{
  static final Map<String, Color> typeColor = {
    'Academic': Colors.green,
    'Health': Colors.red,
    'Motivation': Colors.lightBlue};
  //NOTE: NOT ALL OF THESE WILL BE STRING
  final String type;
  final String descip;
  final String goal;
  final String turnInLoc;
  final String reward;

  Objective(this.type, this.descip, this.goal, this.turnInLoc, this.reward);


  //Displays a pop up that gives more information about the objective
  void moreInfo(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text(goal),
          content: Text(descip),
        );
      }
    );
  }
  

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: <Widget>[
          Text(goal),
          Text(turnInLoc),
          Text(reward),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => moreInfo(context),
          ),
          
        ],
      ),
    );
  }
}