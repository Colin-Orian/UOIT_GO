import 'package:flutter/material.dart';

class Objective{
  static final Map<String, Color> typeColor = {
    'Academic': Colors.green,
    'Health': Colors.red,
    'Motivation': Colors.lightBlue};
  //NOTE: NOT ALL OF THESE WILL BE STRING
  String reference;
  String type;
  String goal;
  String startLoc;
  String turnInLoc;
  String reward;
  int healthChange;
  int motivationChange;
  int gradeInc;


  Objective(this.goal,this.startLoc,  this.turnInLoc, this.reward, this.healthChange, this.motivationChange);


  Objective.fromMap(Map<String, dynamic> map, this.reference){
    this.goal = map['goal'];
    this.startLoc = map['startLoc'];
    this.turnInLoc = map['turnIn'];
    this.reward = map['reward'];
    this.healthChange = map['health'];
    this.motivationChange = map['motiv'];
    this.gradeInc = map['gradeInc'];
  }

  Map<String, dynamic> toMap(){
    return {
      'goal': this.goal,
      'reward': this.reward,
      'health': this.healthChange,
      'motiv': this.motivationChange,
      'turnIn': this.turnInLoc,
      'startLoc': this.startLoc,
      'gradeInc': this.gradeInc,
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
          content: Column(
            children: <Widget>[
              Text('Health change: $healthChange'),
              Text('Motivation change: $motivationChange'),
              Text('Course: $reward'),
              Text('Grade Increaes: $gradeInc'),
            ],
          ),
        );
      }
    );
  }


  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(goal),
              IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => moreInfo(context),
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Text('Turn in at $turnInLoc',overflow: TextOverflow.fade,),
        ],
      ),
    );
  }
}