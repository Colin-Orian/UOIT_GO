import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 10,
        height: 10,
        child: Text("this is test"),
      )
    );
  }
}

class Character{
  double health;
  double motivation;

  List _inventory =[];
  List _loadout = [];
  List _activities = [];

  Character({health,motivation});

  List getInv(){
    return _inventory;
  }

  List getLoad(){
    return _loadout;
  }
  
  List getAct(){
    return _activities;
  }
}
