import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Objective.dart';
class ActivitesPage extends StatefulWidget{
  ActivitesPage({Key key, this.title, this.location}) : super(key: key);
  final String location;
  final String title;

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState(location);
}

class _ActivitiesPageState extends State<ActivitesPage>{
  int _selectedIndex = -1;
  String location;
  List<Objective> objectives;
  List<Widget> tiles;
  String _category = 'All';
  Stream<QuerySnapshot> stream;
  StreamBuilder<QuerySnapshot> streamBuilder;

  _ActivitiesPageState(String location){
    this.location = location;
    this.tiles = new List<Widget>();
    this.stream = _category == 'All'?  Firestore.instance.collection('Objectives').snapshots() :
                  Firestore.instance.collection('Objectives').where('type', isEqualTo:_category).snapshots();
    
  }

  void select(int index){
      _selectedIndex = index;
      setState(() {
        getAllObj();
      });
  }
  void getAllObj(){
    List<Widget> result = new List<Widget>();
    for(int i = 0; i < objectives.length; i ++){
      ListTile temp;
      if(_selectedIndex == i){
        print("this was selected");
        temp =ListTile(
          title: Row(children:[ 
            IconButton(icon: Icon(Icons.check), onPressed: () => select(-1)),
            objectives[i].build(context),])
        );
      }else{
        temp =ListTile(
          title: Row(children:[ 
            IconButton(icon: Icon(Icons.save), onPressed: () => select(i)),
            objectives[i].build(context),])
        );
      }
      result.add(temp);
    }
    tiles = result;
  }
  

  void makeStreamBuilder() {
    streamBuilder = StreamBuilder<QuerySnapshot>(
      stream: this.stream,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        objectives = snapshot.data.documents.map((data) => Objective.fromMap(data.data, data.documentID)).toList();
        getAllObj();
        return ListView(
          children: tiles,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    makeStreamBuilder();
    return Scaffold(
      appBar: AppBar(
        title: Text("hello there! "),
      ),
      body: streamBuilder,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=>{
            if(_selectedIndex != -1){
              Navigator.of(context).pop(objectives[_selectedIndex]) //RACE CONDITION. WHAT IF THE STREAM CHANGES???
            }else{
              Navigator.of(context).pop(null)
            }
            
            
          },
      ),
    );
  }
}