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

  Widget buildItem(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0,color:Colors.black),
          left: BorderSide(width: 1.0,color:Colors.black),
          right: BorderSide(width: 1.0,color:Colors.black),
          bottom: BorderSide(width: 1.0,color:Colors.black),
        ),
        color: _chooseColor()
      ),
      child: IconButton(
        icon: _picture,
        onPressed: (){_itemDetailDialog(context);},
        //color: _chooseColor(),
      ),
      //color:_chooseColor(),
    );
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

//TODO customize dialog for each item type.
  Future<void>_itemDetailDialog(BuildContext context)async{
    var chocie=await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          backgroundColor: _chooseColor(),
          //Actual Widget shown inside of dialog box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              itemTitle(context),
              itemDesc(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('cancel'),
                    onPressed: (){Navigator.pop(context,false);},
                  ),
                  SimpleDialogOption(
                    child: Text('use'),
                    onPressed: (){Navigator.pop(context,true);},
                  )
                ],
              )
            ],
          ),
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

  @override
  Future<void>_itemDetailDialog(BuildContext context)async{
    var chocie=await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          backgroundColor: _chooseColor(),
          //Actual Widget shown inside of dialog box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              itemTitle(context),
              itemDesc(context),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 4.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('cancel'),
                    onPressed: (){Navigator.pop(context,false);},
                  ),
                  SimpleDialogOption(
                    child: Text('use'),
                    onPressed: (){Navigator.pop(context,true);},
                  )
                ],
              )
            ],
          ),
        );
      }
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
  Future<void>_itemDetailDialog(BuildContext context)async{
    var chocie=await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          backgroundColor: _chooseColor(),
          //Actual Widget shown inside of dialog box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              itemTitle(context),
              itemDesc(context),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 4.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('cancel'),
                    onPressed: (){Navigator.pop(context,false);},
                  ),
                  SimpleDialogOption(
                    child: Text('use'),
                    onPressed: (){Navigator.pop(context,true);},
                  )
                ],
              )
            ],
          ),
        );
      }
    );
  }
}