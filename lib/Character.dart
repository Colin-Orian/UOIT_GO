class Character{
  double health;
  double motivation;

  List _inventory =[];
  List _loadout = [];
  List _activities = [];

  Character({health,motivation});

  List getInv(){
    return _inventory;
  }

  List getLoad(){
    return _loadout;
  }
  
  List getAct(){
    return _activities;
  }
}
