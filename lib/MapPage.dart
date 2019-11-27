import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'GPSInfo.dart';
import 'Character.dart';
import 'Objective.dart';
import 'ActivitesPage.dart';
import 'MapInfo.dart';
import 'Places.dart';
class MapPage extends StatefulWidget{
  MapPage({Key key, this.title, this.context}) : super(key: key);
  final BuildContext context;
  final String title;

  @override
  _MapPageState createState() => _MapPageState(context,);
}

class _MapPageState extends State<MapPage>{

  BuildContext context;
  Location _location;
  double _lat;
  double _long;
  _MapPageState(BuildContext context,){
    this.context =context;
    _location = new Location();
    _location.changeSettings(accuracy: LocationAccuracy.HIGH);
    _location.onLocationChanged().listen((LocationData currentLocation){
      setState(() {
        _lat =currentLocation.latitude;
        _long =currentLocation.longitude;  
        building = Places.currentPlace(_lat, _long);
        if(null == building){
          building = 'Loading...';
        }
      });      
    });
  }
  String building;
  Objective objective = new Objective('Academic', 'pizza', 'get pizza', 'Home', 'good grades', -10, -10);

  //Creates a button to turn in the current objected. disable the button if you aren't in the required location
  Widget turnInButton(){
    if(objective.turnInLoc == building){
      return RaisedButton(
        child: Text("Turn in"),
        onPressed: () => turnIn(),
      );
    }else{
      return RaisedButton(
        
        child: Text("Can't turn in"),
        onPressed: null,
      );
    }
  }
//prompts the user if they want to turn in the objective. If they do, remove the current event
void turnIn(){
    showDialog(
      context: this.context,
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
                  Character.currentHealth +=objective.healthChange;
                  Character.currentMotivation +=objective.motivationChange;
                  objective = new Objective('Health',  'Done', 'done', 'Done', 'Done', 0, 0);     
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

      onTap: () => turnIn(),
    );
  }


//Returns a row of the player's stats
Row createStats(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        child: Text('${Character.currentHealth} / ${Character.maxHealth}',),
        color: Colors.red,
      ),
      Padding(padding: EdgeInsets.all(8),),
      Container(
        child: Text('${Character.currentMotivation} / ${Character.maxMotivation}'),
        color: Colors.blue,
      ),
      
    ],
  );
}

//Open a listview of all the activites at the current location
  void openActivites(){
    
    Navigator.push(context,
     MaterialPageRoute(builder: (context) =>  ActivitesPage(location:building)));
  }

  void openStore(){
    //open a new navigator that contains different items
    Navigator.push(context, MaterialPageRoute(builder: (context) => GPSInfo()));
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Current Location: $building",
            style: TextStyle(fontWeight: FontWeight.bold),),
          objective,
          Text("Player Stats"),
          createStats(),
          turnInButton(),
          RaisedButton(
            child: Text("Activites Here"),
            onPressed: () => openActivites(),
          ),
          RaisedButton(
            child: Text("Store Here"),
            onPressed: () => openStore(),
          ),
          MapInfo(context: context, lat: _lat, long: _long,),
        ],
      ),
    );
  }
}