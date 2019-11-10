import 'package:flutter/material.dart';
import 'Character.dart';
import 'Item.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CharacterPage extends StatefulWidget{
  @override
  _CharacterPageState createState() => _CharacterPageState();
}
class _CharacterPageState extends State<CharacterPage>{
  Character _character;
  //TODO switch to List<Items>
  List<Item> items=[];
  List<Modifier> loadout= [];
  _CharacterPageState(){
    for(int i=0;i<30;i++){
      if(i%2==0){
        items.add(
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
        items.add(
          new Modifier(
            type: "Modifier",
            picture: Icon(Icons.headset),
            itemName: "headset${i/2}",
            description: "headset for fun",
            maxHealthChange: 0.05*i,
            maxMotivationChange: 0.05*i,
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
          Text('New Student Person'),
          //character health progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "50/100",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text("health",
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: 50/100,
            progressColor: Colors.red,
          ),

          //character motivation progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "10/25",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text("motivaton",
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: 10/25,
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
              items[1].buildItem(context),
              items[1].buildItem(context),
              items[1].buildItem(context),
              items[1].buildItem(context),
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
              Text("Storage (${items.length}/64)"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            child: GridView.count(
              crossAxisCount: 8,
              children: items.map((item)=>item.buildItem(context)).toList(),
            )
          ),
        ]
      )
    );
  }
}

