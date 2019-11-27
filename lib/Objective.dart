import 'package:flutter/material.dart';

class Objective{
  static final Map<String, Color> typeColor = {
    'Academic': Colors.green,
    'Health': Colors.red,
    'Motivation': Colors.lightBlue};
  //NOTE: NOT ALL OF THESE WILL BE STRING
  String reference;
  String type;
  String descip;
  String goal;
  String turnInLoc;
  String reward;
  int healthChange;
  int motivationChange;


  Objective(this.type, this.descip, this.goal, this.turnInLoc, this.reward, this.healthChange, this.motivationChange);


  Objective.fromMap(Map<String, dynamic> map, this.reference){
    this.type = map['type'];
    this.descip = map['desc'];
    this.goal = map['goal'];
    this.turnInLoc = map['turnIn'];
    this.reward = map['reward'];
    this.healthChange = map['health'];
    this.motivationChange = map['motiv'];
  }

  Map<String, dynamic> toMap(){
    return {
      'type': this.type,
      'desc': this.descip,
      'goal': this.goal,
      'reward': this.reward,
      'health': this.healthChange,
      'motiv': this.motivationChange,
    };
  }
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