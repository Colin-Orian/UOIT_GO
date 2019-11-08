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
  Color _chooseColor(){
    if(_type=="Consumable"){
      return Colors.red[100];
    }else{
      return Colors.green[50];
    }
  }

  Widget buildItem(){
    return Container(
      child: IconButton(
        icon: _picture,
      ),
      color:_chooseColor(),
    );
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
}