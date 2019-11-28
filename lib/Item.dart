import 'package:flutter/material.dart';

class Item {
  String _type;
  Icon _picture;
  String _itemName;
  String _description;
  double _healthEffect;
  double _motivationEffect;

  Item({String type, Icon, picture, String itemName, String description, double health,double motivation}){
    this._type=type;
    this._picture=picture;
    this._itemName=itemName;
    this._description=description;
    this._healthEffect=health;
    this._motivationEffect=motivation;
  }

  String getType(){return this._type;}
  Icon getPicture(){return this._picture;}
  double getHealthChange(){return _healthEffect;}
  double getMotivationChange(){return _motivationEffect;}
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
          child:Icon(IconData(57744,fontFamily: 'MaterialIcons'))//_picture
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