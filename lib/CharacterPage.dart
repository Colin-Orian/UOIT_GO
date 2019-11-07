import 'package:flutter/material.dart';
import 'Character.dart';

class CharacterPage extends StatefulWidget{
  @override
  _CharacterPageState createState() => _CharacterPageState();
}
class _CharacterPageState extends State<CharacterPage>{
  Character _character;
  //TODO switch to List<Items>
  List<String> items=[];
  _CharacterPageState(){
    for(int i=0;i<30;i++){
      items.add('$i');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _characterProfile(),
        _loadoutProfile(),
        _inventoryProfile(),
      ]
    );
  }

  Widget _characterProfile(){
    return Container(
      child: Text("hi"),
    );
  }

  Widget _loadoutProfile(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("loadout1"),
        Text("loadout2"),
        Text("loadout3"),
        Text("loadout4"),
      ],
    );
  }

  Widget _inventoryProfile(){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      child: GridView.count(
      crossAxisCount: 8,
      children: List.generate(100, (index){
        return Text('item');
      })
      )
    );
  }
}

