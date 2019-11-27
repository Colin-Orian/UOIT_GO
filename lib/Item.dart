import 'package:flutter/material.dart';

class Item {
  String _type;
  Icon _picture;
  String _itemName;
  String _description;

  Item({String type, Icon, picture, String itemName, String description}){
    this._type=type;
    this._picture=picture;
    this._itemName=itemName;
    this._description=description;
  }

  String getType(){return this._type;}
  Icon getPicture(){return this._picture;}
  Color chooseColor(){
    if(_type=="Consumable"){
      return Colors.orange[100];
    }else{
      return Colors.blue[50];
    }
  }

  Color numColor(double value){
    if(value>0){
      return Colors.green;
    }else if(value<0){
      return Colors.red;
    }else{
      return Colors.black;
    }
  }

  Widget itemTitle(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height*0.1,
          child:_picture
        ),
        Text(
          "$_itemName",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget itemDesc(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:5.0),
      width: MediaQuery.of(context).size.width*0.8,
      child: Text(_description, textAlign: TextAlign.center,),
    );
  }

  Widget itemEffect(BuildContext context){
    return Text("error");
  }
}

//items that will be consumed and affect health and motivation
class Consumable extends Item{
  double _healthChange;
  double _motivationChange;
  Consumable({double healthChange,
              double motivationChange,
              String type, 
              String itemName,
              String description,
              Icon picture})
    : super(type:type,
            picture:picture,
            description:description,
            itemName:itemName){
    this._healthChange=healthChange;
    this._motivationChange=motivationChange;
  }
  double getHealthChange(){return _healthChange;}
  double getMotivationChange(){return _motivationChange;}

  @override
  Widget itemEffect(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: 4.0),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Health",textAlign: TextAlign.center,),
            Text("Motivation",textAlign: TextAlign.center,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "$_healthChange",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_healthChange),
                fontSize: 30.0,
              ),
            ),
            Text(
              "$_motivationChange",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_motivationChange),
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}


class Modifier extends Item{
  double _maxHealthChange;
  double _maxMotivationChange;
  Modifier({double maxHealthChange,
              double maxMotivationChange,
              String type, 
              String itemName,
              String description,
              Icon picture})
    : super(type:type,
            picture:picture,
            description:description,
            itemName:itemName){
    this._maxHealthChange=maxHealthChange;
    this._maxMotivationChange=maxMotivationChange;
  }
  double getMaxHealthChange(){return _maxHealthChange;}
  double getMaxMotivationChange(){return _maxMotivationChange;}

  @override
  Widget itemEffect(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: 4.0),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Health",textAlign: TextAlign.center,),
            Text("Motivation",textAlign: TextAlign.center,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "$_maxHealthChange",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_maxHealthChange),
                fontSize: 30.0,
              ),
            ),
            Text(
              "$_maxMotivationChange",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_maxMotivationChange),
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}