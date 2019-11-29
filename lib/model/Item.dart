import 'package:flutter/material.dart';

class Item {
  String _type;
  int _pictureID;
  String _itemName;
  String _description;
  double _healthEffect;
  double _motivationEffect;
  int _inLoadout;
  int _id;

  Item({int id,String type, int pictureID, String itemName, String description, double health,double motivation, int inLoadout}){
    this._type=type;
    this._pictureID=pictureID;
    this._itemName=itemName;
    this._description=description;
    this._healthEffect=health;
    this._motivationEffect=motivation;
    this._inLoadout=inLoadout;
    this._id=id;
  }

  int getID(){return this._id;}
  String getType(){return this._type;}
  int getPictureID(){return this._pictureID;}
  double getHealthChange(){return _healthEffect;}
  double getMotivationChange(){return _motivationEffect;}
  Color chooseColor(){
    if(_type=="Consumable"){
      return Colors.orange[100];
    }else{
      return Colors.blue[50];
    }
  }

  String toString(){
    return "$_itemName, $_type, $_healthEffect, $_motivationEffect, $_pictureID";
  }

  Item.fromMap(Map<String,dynamic> map){
    this._id=map['id'];
    this._type=map['type'];
    this._description=map['description'];
    this._itemName=map['name'];
    this._healthEffect=map['health'];
    this._motivationEffect=map['motivation'];
    this._pictureID=map['iconID'];
    this._inLoadout=map['inLoadout'];
  }

  Map<String,dynamic> toMap(){
    return{
      'id':this._id,
      'type':this._type,
      'description':this._description,
      'name':this._itemName,
      'health':this._healthEffect,
      'motivation':this._motivationEffect,
      'iconID':this._pictureID,
      'inLoadout':this._inLoadout
    };
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
          child:Icon(IconData(_pictureID,fontFamily: 'MaterialIcons'))//_picture
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
  Icon getPicture(){
    return Icon(IconData(_pictureID,fontFamily: 'MaterialIcons'));
  }

  Widget itemDesc(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:5.0),
      width: MediaQuery.of(context).size.width*0.8,
      child: Text(_description, textAlign: TextAlign.center,),
    );
  }

  Widget itemEffect(BuildContext context){
    if(_type=="Consumable"){
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
              "$_healthEffect",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_healthEffect),
                fontSize: 30.0,
              ),
            ),
            Text(
              "$_motivationEffect",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_motivationEffect),
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ],
    ); 
    }else if(_type=="Modifier"){
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
              "$_healthEffect",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_healthEffect),
                fontSize: 30.0,
              ),
            ),
            Text(
              "$_motivationEffect",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: numColor(_motivationEffect),
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ],
    ); 
    }else{
      return Text("error");
    }
  }
}