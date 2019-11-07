import 'package:flutter/material.dart';
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

  //TODO read in the objectives from the cloud database and create a list of them
  List<Objective> getAllObj(){
    print('Objectives at $location');
    List<Objective> result = new List<Objective>();
    Objective tempObj =Objective('Motivation', 'Get sleep', 'go to sleep', 'UL', 'More Motivation');
    result.add(tempObj);
    result.add(tempObj);
    result.add(tempObj);
    result.add(tempObj);
    result.add(tempObj);
    return result;
  }
  _ActivitiesPageState(String location){
    this.location = location;
    objectives = new List<Objective>();
    objectives =  getAllObj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello there! "),
      ),
      body: ListView(
        //Go through each objective and convert them into a list of widgets
        children: objectives.map((Objective objective){
          return objective.build(context);
        }).toList()
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=>{
            //TODO pop the selected objectives off of the navigator
          },
        ),
      );
  }
}