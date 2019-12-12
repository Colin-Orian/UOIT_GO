import 'package:flutter/material.dart';
import 'Character.dart';
import 'Objective.dart';

//This class will list all the objectives that the player currently has. The player can then select which
//objective to work towards
class ListObjectivesPage extends StatefulWidget{
  ListObjectivesPage({Key key, this.title, this.context}) : super(key: key);
  final BuildContext context;
  final String title;

  @override
  _ListObjectivesPageState createState() => _ListObjectivesPageState(context,);
  
}

class _ListObjectivesPageState extends State{
  BuildContext _context;
  int _selectedIndex = -1;
  List<Objective> objectives;


  _ListObjectivesPageState(BuildContext context){
    _context =context;
    objectives = Character.getAct();
  }
  //Select a desired objective and show that the objective was selected
  void _select(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  //build all the objectives with a button to select them
  List<Widget> wrapObj(){
    List<Widget> result = new List<Widget>();
    for(int i = 0; i < objectives.length; i ++){
      ListTile temp;
      if(_selectedIndex == i){
        temp =ListTile(
          title: Row(children:[ 
            IconButton(icon: Icon(Icons.check), onPressed: () => _select(-1)),
            objectives[i].build(context),])
        );
      }else{
        temp =ListTile(
          title: Row(children:[ 
            IconButton(icon: Icon(Icons.save), onPressed: () => _select(i)),
            objectives[i].build(context),])
        );
      }
      result.add(temp);
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: wrapObj(),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=>{
            //Pop the selected objective
            if(_selectedIndex != -1){
              
              Navigator.of(context).pop(objectives[_selectedIndex])
            }else{
              Navigator.of(context).pop(null)
            }
          },
      ),
    );
  }
}

