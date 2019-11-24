import 'package:flutter/material.dart';
import 'Character.dart';
import 'Item.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CharacterPage extends StatefulWidget{
  CharacterPage({Character this.character});
  Character character;

  @override
  _CharacterPageState createState() => _CharacterPageState(character );
}


class _CharacterPageState extends State<CharacterPage>{
  //Test Character
  //Character _character=new Character(health: 100.0,motivation: 30.0,invSize: 54,name: "Amazing Student");
  Character _character;
  _CharacterPageState(Character character){
    this._character = character;
    print(this._character.currentHealth);
    //Fills 30 items for testing
    for(int i=0;i<30;i++){
      if(i%2==0){
        _character.addItemInv(
          new Consumable(
            type: "Consumable",
            picture: Icon(Icons.fastfood),
            itemName: "fastFood${i/2}",
            description: "junk food for some quick motivation to really help move forward",
            healthChange: i*-0.5,
            motivationChange: i*0.5,
          )
        );
      }else{
        _character.addItemInv(
          new Modifier(
            type: "Modifier",
            picture: Icon(Icons.headset),
            itemName: "headset${i/2}",
            description: "headset for fun",
            maxHealthChange: i*1.0,
            maxMotivationChange: i*1.0,
          )
        );
      }
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

//Widget of the profile, with the health, motivation, and name
  Widget _characterProfile(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
      height: MediaQuery.of(context).size.height*0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //character name
          Text(_character.name),

          //character health progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "${_character.currentHealth}/${_character.maxHealth}",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text("health",
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: _character.currentHealth/_character.maxHealth,
            progressColor: Colors.red,
          ),

          //character motivation progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "${_character.currentMotivation}/${_character.maxMotivation}",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text("motivaton",
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: _character.currentMotivation/_character.maxMotivation,
            progressColor: Colors.blue,
          ),
        ],
      )
    );
  }

  Widget _loadoutProfile(){
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Loadout (4/4)"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _character.getInv()[1].buildItem(context),
              _character.getInv()[1].buildItem(context),
              _character.getInv()[1].buildItem(context),
              _character.getInv()[1].buildItem(context),
            ],
          )
        ],
      )
    );
  }

  Widget _inventoryProfile(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical:5.0),
      child: Column(
        children:<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.work),
              Text("Storage (${_character.getInv().length}/64)"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            child: GridView.count(
              crossAxisCount: 8,
              children: _character.getInv().map((item)=>item.buildItem(context)).toList(),
            )
          ),
        ]
      )
    );
  }
}

