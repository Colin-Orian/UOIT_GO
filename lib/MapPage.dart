import 'package:flutter/material.dart';
import 'Objective.dart';
class MapPage extends StatefulWidget{
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  String location = "UA";
  Objective objective = new Objective('Academic', 'pizza', 'get pizza', 'UA', 'good grades');
  void openActivites(){
    //Open a new navigator that contains different objectives
    //navigator.push(Activities(location)).... /shrug
  }

  void openStore(){
    //open a new navigator that contains different items
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Current Location: $location",
            style: TextStyle(fontWeight: FontWeight.bold),),
          objective.build(context),
          RaisedButton(
            child: Text("Activites Here"),
            onPressed: () => openActivites(),
          ),
          RaisedButton(
            child: Text("Store Here"),
            onPressed: () => openStore(),
          ),
        ],
      ),
    );
  }
}