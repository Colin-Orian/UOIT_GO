import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This is the Character Page"),
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
