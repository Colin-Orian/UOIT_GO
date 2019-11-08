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
  Widget buildItem(BuildContext context){
    return Container(
      child: IconButton(
        icon: _picture,
        onPressed: (){_itemDetailDialog(context);},
      ),
      color:Colors.blue,
    );
  }

//TODO customize dialog for each item type.
  Future<void>_itemDetailDialog(BuildContext context)async{
    var chocie=await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(_itemName),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('use'),
              onPressed: (){Navigator.pop(context,true);},
            ),
            SimpleDialogOption(
              child: Text('cancel'),
              onPressed: (){Navigator.pop(context,false);},
            )
          ],
        );
      }
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
/*
  @override
  Widget buildItem(){
    return Container(
      child: IconButton(
        icon: _picture,
        onPressed:(){ _itemDetailDialog();},
      ),
      color:_chooseColor(),
    );
  }

  void _itemDetailDialog() {
    showDialog(
      //context: context,
      barrierDismissible:true,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: _chooseColor(),
          child: _itemDetailWidget()
        );
      }
    );
  }

  Widget _itemDetailWidget(){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _picture,

          ],
        )
      ],
    );
  }*/
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
/*
  @override
  Widget buildItem(){
    return Container(
      child: IconButton(
        icon: _picture,
      ),
      color:_chooseColor(),
    );
  }*/
}