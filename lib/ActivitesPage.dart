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
  String location;
  List<Objective> objectives;
  StreamBuilder<QuerySnapshot> streamBuilder;
  String _category = 'All';
  List<Widget> getAllObj(){
    List<Widget> result =objectives.map((Objective obj){
      return obj.build(context);
    }).toList();
    return result;
  }
  _ActivitiesPageState(String location){
    this.location = location;
    streamBuilder =StreamBuilder<QuerySnapshot>(
      stream: _category == 'All'?  Firestore.instance.collection('Objectives').snapshots() : Firestore.instance.collection('Objectives').where('type', isEqualTo:_category).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        objectives = snapshot.data.documents.map((data) => Objective.fromMap(data.data, data.documentID)).toList();
        return ListView(
          children: objectives.map((Objective obj){
            return obj.build(context);}).toList(),
        );
        //children: objectives.map((Objective obj){
          //return obj.build(context);}).toList());

      },
    );
    //objectives = new List<Objective>();
    //objectives =  getAllObj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello there! "),
      ),
      body: streamBuilder,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=>{
            //TODO pop the selected objectives off of the navigator
          },
      ),
    );
  }
}