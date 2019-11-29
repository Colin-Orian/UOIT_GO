import 'package:flutter/material.dart';
import 'Character.dart';
import 'model/Item.dart';
import 'model/ItemModel.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CharacterPage extends StatefulWidget{
  CharacterPage();

  @override
  _CharacterPageState createState() => _CharacterPageState();
}


class _CharacterPageState extends State<CharacterPage>{
  final _model = ItemModel();
  //Test Character  
  _CharacterPageState(){
    //this._character = character;
    //Fills 30 items for testing
    
    for(int i=0;i<60;i++){
      if(i%2==0){
        _model.insertItem(
          new Item(
            id: i,
            type: "Consumable",
            pictureID: Icons.fastfood.codePoint,
            itemName: "fastFood${i/2}",
            description: "junk food for some quick motivation to really help move forward",
            health: i*-0.5,
            motivation: i*0.5,
            inLoadout: 0,
          )
        );
      }else{
        _model.insertItem(
          new Item(
            id: i,
            type: "Modifier",
            pictureID: Icons.headset.codePoint,
            itemName: "headset${i/2}",
            description: "headset for fun",
            health: i*1.0,
            motivation: i*1.0,
            inLoadout: 0,
          )
        );
      }
    }
    _setInventory();
    _model.getAllItems();
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

  Future<void> _setInventory() async {
    List<Item>  temp = await _model.getAllItems();
    setState(() {
      Character.setInv(temp);
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
            leading: Text("health",
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
            leading: Text("motivaton",
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
              buildItem(context,Character.getInv()[0]),
              buildItem(context,Character.getInv()[0]),
              buildItem(context,Character.getInv()[0]),
              buildItem(context,Character.getInv()[0]),
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
              Text("Storage (${Character.getInv().length}/64)"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            child: GridView.count(
              crossAxisCount: 8,
              children: Character.getInv().map((item)=>buildItem(context,item)).toList(),            )
          ),
        ]
      )
    );
  }

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

  Widget _itemDialogOptions(BuildContext context, Item item){
    if(item.getType()=="Consumable"){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Use'),
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
            child: Text('Delete'),
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
            child: Text('Equip'),
            onPressed: (){Navigator.pop(context,false);},
          ),
          SimpleDialogOption(
            child: Text('Delete'),
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
    }
  }


}

