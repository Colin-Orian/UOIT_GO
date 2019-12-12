import 'model/Item.dart';
import 'Objective.dart';

//
class Character{
  static double currentHealth;
  static double maxHealth;
  static double currentMotivation;
  static double maxMotivation;
  static int invSize;
  static String name;
  static String prevLocation;
  static List<Item> _inventory =[];
  static List<Item> _loadout = [];
  static List<Objective> _activities = [];


//loads initial values for character on launch
static void loadCharacter({health,motivation,numInv, characterName}){
    maxHealth=health;
    maxMotivation=motivation;
    invSize=numInv;
    name=characterName;

    //sets characters current health and motivation to be full.
    currentHealth=maxHealth;
    currentMotivation=maxMotivation;
  }

//equips item along with checking conditions around max and min health
  static void equipModifier(Item item){
    if(maxHealth+item.getHealthChange()>=0){
      maxHealth+=item.getHealthChange();
      if(currentHealth+item.getHealthChange()>=0){
      currentHealth+=item.getHealthChange();
      }
    }else{
      maxHealth=0;
      currentHealth=0;
    }
    if(maxMotivation+item.getMotivationChange()>=0){
      maxMotivation+=item.getMotivationChange();
      if(currentMotivation+item.getMotivationChange()>=0){
        currentMotivation+=item.getMotivationChange();
      }
    }else{
      maxMotivation=0;
    }
  }


//remove item from loadout and remove corresponding effects
  static void unequipModifier(Item item){
    if(maxHealth-item.getHealthChange()>=0){
      maxHealth-=item.getHealthChange();
      if(currentHealth-item.getHealthChange()>=0){
      currentHealth-=item.getHealthChange();
      }
    }else{
      maxHealth=0;
      currentHealth=0;
    }
    if(maxMotivation-item.getMotivationChange()>=0){
      maxMotivation-=item.getMotivationChange();
      if(currentMotivation-item.getMotivationChange()>=0){
        currentMotivation-=item.getMotivationChange();
      }
    }else{
      maxMotivation=0;
    }
  }

//use item with corresponding effects, check conditions around max and min health
  static void useConsumable(Item item){
    if(item.getHealthChange()+currentHealth>maxHealth){
      currentHealth=maxHealth;
    }else if(item.getHealthChange()+currentHealth<=0){
      currentHealth=0;
    }else{
      currentHealth+=item.getHealthChange();
    }
    if(item.getMotivationChange()+currentMotivation>maxMotivation){
      currentMotivation=maxMotivation;
    }else if(item.getMotivationChange()+currentMotivation<=0){
      currentMotivation=0;
    }else{
      currentMotivation+=item.getMotivationChange();
    }
  }

//remove item from inventory
  static void removeItemInv(Item item){
    _inventory.remove(item);
  }

  //return character inventory
  static List<Item> getInv(){
    return _inventory;
  }

//sets the characters inventory
  static void setInv(List<Item> inv){
    _inventory=inv;
  }

//sets the characters loadout
  static void setLoadout(List<Item> load){
    _loadout=load;
  }

  //return character loadout
  static List<Item> getLoad(){
    return _loadout;
  }
  //Append an objective to the end of the acivities
  static void addAct(Objective obj){
    _activities.add(obj);
  }
  //return character activities
  static List<Objective> getAct(){
    print(_activities.length);
    return _activities;
  }

  //add item to inventory
  static void addItemInv(Item item){
    _inventory.add(item);
  }

  //add modifier to loadout
  static void addModLoad(Item modifier){
    _loadout.add(modifier);
  }

  //returns if inventory is full
  static bool isInvFull(){
    return _inventory.length==invSize;
  }

  //returns if loadout is full
  static bool isLoadFull(){
    return _loadout.length==4;
  }



  Character.fromMap(Map<String,dynamic> map){
    currentHealth=map['curHealth'];
    maxHealth=map['maxHealth'];
    currentMotivation=map['curMotiv'];
    maxMotivation=map['maxMotiv'];
    invSize=map['invSize'];
    name=map['name'];
    prevLocation=map['prevLoc'];
  }

  static Map<String,dynamic> toMap(){
    return{
      'name':name,
      'curHealth':currentHealth,
      'maxHealth':maxHealth,
      'curMotiv':currentMotivation,
      'maxMotiv':maxMotivation,
      'invSize':invSize,
      'prevLoc':prevLocation
    };
  }

}
