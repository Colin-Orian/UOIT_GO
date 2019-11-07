import 'package:flutter/material.dart';
import 'Objective.dart';
import 'ActivitesPage.dart';
class MapPage extends StatefulWidget{
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  String location = "UA";
  Objective objective = new Objective('Academic', 'pizza', 'get pizza', 'UA', 'good grades');

//prompts the user if they want to turn in the objective. If they do, remove the current event
Future<void> turnIn(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Turn in event?"),
          actions: <Widget>[
            FlatButton(
              child: Text('yes'),
              //OnPressed will change the current objective to empty and do the required
              //Changes to the character's inventory / stats
              onPressed: (){
                setState(() {
                  objective = new Objective('Health',  'Done', 'done', 'Done', 'Done');
                });

                Navigator.of(context).pop();
              }
            ),
            FlatButton(
              child: Text('no'),
              onPressed: (){
                Navigator.of(context).pop();
              },),
          ],
        );
      }
    );
  }

//Wraps the current objective in a GestureDetetor
  GestureDetector createGesture(Objective obj){
    return GestureDetector(
      child: obj.build(context),

      onTap: () => turnIn(context),
    );
  }
  void openActivites(){
    
    Navigator.push(context,
     MaterialPageRoute(builder: (context) =>  ActivitesPage(location:location)));
  }

  void openStore(){
    //open a new navigator that contains different items
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Current Location: $location",
            style: TextStyle(fontWeight: FontWeight.bold),),
          createGesture(objective),
          RaisedButton(
            child: Text("Activites Here"),
            onPressed: () => openActivites(),
          ),
          RaisedButton(
            child: Text("Store Here"),
            onPressed: () => openStore(),
          ),
        ],
      ),
    );
  }
}