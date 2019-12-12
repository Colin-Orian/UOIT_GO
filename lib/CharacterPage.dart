import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'Character.dart';
import 'model/Item.dart';
import 'model/ItemModel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//class to show the character page of the application
class CharacterPage extends StatefulWidget{
  BuildContext context;
  CharacterPage({Key key,this.context}):super(key:key);

  @override
  _CharacterPageState createState() => _CharacterPageState(context);
}


class _CharacterPageState extends State<CharacterPage>{
  BuildContext context;
  final _model = ItemModel();
  bool isInitLaunch=true;
  //initial setting of characters inventory from database
  _CharacterPageState(context){
    this.context=context;
    _setInventory();
    _model.getAllItems();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _characterProfile(),
        _loadoutProfile(),
        _freeItemButton(),
        _inventoryProfile(),
      ]
    );
  }

//sets the characters inventory and loadout from database
  Future<void> _setInventory() async {
    List<Item>  temp = await _model.getAllItems();
    List<Item> loadoutTemp = [];
    for(Item item in temp){
      if(item.isInLoadout()==1){
        loadoutTemp.add(item);
        if(isInitLaunch){
          Character.equipModifier(item);
        }
      }
    }
    isInitLaunch=false;
    setState(() {
      Character.setInv(temp);
      Character.setLoadout(loadoutTemp);
    });
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
          Text(Character.name),

          //character health progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "${Character.currentHealth}/${Character.maxHealth}",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text(FlutterI18n.translate(context,"Character.health"),
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: Character.currentHealth/Character.maxHealth,
            progressColor: Colors.red,
          ),

          //character motivation progress bar
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width-100,
            alignment: MainAxisAlignment.end,
            center: Text(
              "${Character.currentMotivation}/${Character.maxMotivation}",
              style: TextStyle(color: Colors.black),
              ),
            leading: Text(FlutterI18n.translate(context,'Character.motivation'),
            style: TextStyle(color: Colors.black),
            ),
            lineHeight: MediaQuery.of(context).size.height*0.03,
            percent: Character.currentMotivation/Character.maxMotivation,
            progressColor: Colors.blue,
          ),
        ],
      )
    );
  }

//shows message if empty loadout. otherwise displays items
  Widget _loadoutCheck(){
    if(Character.getInv().length != 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: Character.getLoad().map((item)=>buildItem(context,item)).toList(),
      );
    }else{
      return Text('enpty loadout');
    }
  }

  //displays users loadout with item count
  Widget _loadoutProfile(){
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text( FlutterI18n.translate(context,
          "Character.loadout")+ 
          " (${Character.getLoad().length}/4)"),
          _loadoutCheck(),
        ],
      )
    );
  }


//Displays users inventory along with the amount of items
  Widget _inventoryProfile(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical:5.0),
      child: Column(
        children:<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.work),
              Text(FlutterI18n.translate(context, 
              "Character.storage") +
              "(${Character.getInv().length}/64)"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            child: GridView.count(
              crossAxisCount: 8,
              children: Character.getInv().map((item)=>buildItem(context,item)).toList(),            )
          ),
        ]
      )
    );
  }

//Button to retrieve free item into users inventory 
  Widget _freeItemButton(){
    return Container(
      padding: EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height*0.08,
      width: double.infinity,
      child:FlatButton(
        onPressed: (){
          if(Character.getInv().length==64){
            final snackBar = SnackBar(
              content: Text('Inventory Full!  Cannot get item!'),
              duration: Duration(milliseconds: 1300),
            );
            Scaffold.of(this.context).showSnackBar(snackBar);
          }else{
            _randomItem();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.purple,
              ],
            )
          ),
          child: Text(
            "Free Random Item",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32),
          ),
        ),
      )
    );
  }

//takes in the item class and builds widget
  Widget buildItem(BuildContext context, Item item){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color:Colors.black),
        color: item.chooseColor()
      ),
      child: IconButton(
        icon: item.getPicture(),
        onPressed: (){
          _itemDetailDialog(context, item);
          },
        //color: _chooseColor(),
      ),
      //color:_chooseColor(),
    );
  }

//builds dialog when user clicks on item
  Future<void>_itemDetailDialog(BuildContext context, Item item)async{
    var chocie=await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          backgroundColor: item.chooseColor(),
          //Actual Widget shown inside of dialog box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              item.itemTitle(context),
              item.itemDesc(context),
              item.itemEffect(context),
              _itemDialogOptions(context,item),
            ],
          ),
        );
      }
    );
  }

//different options for dialog based on if consumable or modifier.
//consumables can be used, modifiers can be equiped.
  Widget _itemDialogOptions(BuildContext context, Item item){
    if(item.getType()=="Consumable"){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context,
            "Character.use")),
            onPressed: (){
              setState(() {
                Character.removeItemInv(item);
                Character.useConsumable(item);
              });
              _model.deleteItem(item);
              _setInventory();
              Navigator.pop(context,false);
              },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context,
            "Character.delete")),
            onPressed: (){
              setState(() {
                Character.removeItemInv(item);
              });
              _model.deleteItem(item);
              _setInventory();
              Navigator.pop(context,true);
            },
          )
        ],
      );
    }else if(item.getType()=="Modifier"){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SimpleDialogOption(
            child: ((){
              if(item.isInLoadout()==1){
                return Text("Unequip");
              } else{
                return Text(FlutterI18n.translate(context,
            "Character.equip"));
              }
            }()),
            onPressed: (){
              if(item.isInLoadout()==1){
                setState(() {
                  Character.unequipModifier(item);
                item.setEquip(0);
                _model.updateItem(item);
                _setInventory();
              });
              Navigator.pop(context,false);
              }else{
                if(Character.getLoad().length==4){
                  final snackBar = SnackBar(
                    content: Text('Loadout Full!  Cannot equip item!'),
                    duration: Duration(milliseconds: 1300),
                  );
                  Scaffold.of(this.context).showSnackBar(snackBar);
                }else{
                  setState(() {
                    Character.equipModifier(item);
                    item.setEquip(1);
                    _model.updateItem(item);
                    _setInventory();
                  });
                }
              Navigator.pop(context,false);
              }
            },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context,
            "Character.delete")),
            onPressed: (){
              setState(() {
                if(item.isInLoadout()==1){
                  Character.unequipModifier(item);
                }
                Character.removeItemInv(item);
              });
              _model.deleteItem(item);
              _setInventory();
              Navigator.pop(context,true);
            },
          )
        ],
      );
    }
  }

//retrieves random item from firebase database.
  void _randomItem() {
    List<Item> itemPull=[];
    final items = Firestore.instance.collection('items');
    items.snapshots().listen((data){
      for(var doc in data.documents){
        final item =  Item.fromMap(doc.data);
        itemPull.add(item);
        print(item.toString());
      }
      Item newItem = (itemPull..shuffle()).first;
      print(newItem.toString());
      _model.insertItem(newItem);
      _setInventory();
    });
    
  }


}

