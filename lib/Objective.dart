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

  

/*
//Creates an widget that displays the data.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(type),
             Row(
              children: <Widget>[
                Text('Goal: $goal'),
                Icon(Icons.check_box_outline_blank),
              ],
            ),
            Text('Reward: $reward'),
          ],
        ),
        decoration: BoxDecoration(
        color: typeColor[type],
      ),
    );*/

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: <Widget>[
          Icon(Icons.update),
          Text(goal),
          Text(turnInLoc),
          Text(reward),
          Icon(Icons.info),
        ],
      ),
    );
  }
}