import 'Item.dart';

class Character{
  double currentHealth;
  double maxHealth;
  double currentMotivation;
  double maxMotivation;
  int invSize;
  String name;

  List<Item> _inventory =[];
  List<Modifier> _loadout = [];
  List _activities = [];

  Character({health,motivation,invSize,name}){
    this.maxHealth=health;
    this.maxMotivation=motivation;
    this.invSize=invSize;
    this.name=name;

    //sets characters current health and motivation to be full.
    this.currentHealth=maxHealth;
    this.currentMotivation=maxMotivation;
  }

  //return character inventory
  List<Item> getInv(){
    return _inventory;
  }

  //return character loadout
  List<Modifier> getLoad(){
    return _loadout;
  }
  
  //return character activities
  List getAct(){
    return _activities;
  }

  //add item to inventory
  void addItemInv(Item item){
    _inventory.add(item);
  }

  //add modifier to loadout
  void addModLoad(Modifier modifier){
    _loadout.add(modifier);
  }

  //returns if inventory is full
  bool isInvFull(){
    return _inventory.length==invSize;
  }

  //returns if loadout is full
  bool isLoadFull(){
    return _loadout.length==4;
  }
}
