import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:location/location.dart';

import 'Notifications.dart';
import 'Character.dart';
import 'Objective.dart';
import 'ActivitesPage.dart';
import 'MapInfo.dart';
import 'Places.dart';
import 'ListObjectivesPage.dart';
import 'model/CourseModel.dart';
import 'model/Course.dart';
/* 
  This class lets the user see where they are on Campus and allows them to interact with
  the different locations. For example, the user can turn in an objective or look at the objectives 
  at the current building
*/
class MapPage extends StatefulWidget{
  MapPage({Key key, this.title, this.context}) : super(key: key);
  final BuildContext context;
  final String title;

  @override
  _MapPageState createState() => _MapPageState(context,);
}

class _MapPageState extends State<MapPage>{
  Notifications _notifications;
  BuildContext context;
  Location _location;
  final CourseModel _model =CourseModel();
  double _lat;
  double _long;
  bool hasObjecitive = false;
  _MapPageState(BuildContext context,){
    _notifications =Notifications();
    _notifications.init();

    this.context =context;
    _location = new Location();
    _location.changeSettings(accuracy: LocationAccuracy.HIGH);
    _location.onLocationChanged().listen((LocationData currentLocation){
      if(mounted){
        setState(() {
          _lat =currentLocation.latitude;
          _long =currentLocation.longitude;  
          Character.prevLocation = building;
          building = Places.currentPlace(_lat, _long);
          if(null == building){
            building = 'Loading...';
          }else if(building != Character.prevLocation && Character.prevLocation != 'null'){
            _notifications.sendNotification('Moved to another location!', building, 'payload');
          }
        }); 
      }
    });
  }
  String building;
  Objective objective;// = new Objective('Academic', 'pizza', 'get pizza', 'No Location', 'good grades', -10, -10);

  //Creates a button to turn in the current objected.
  //disable the button if you aren't in the required location
  Widget turnInButton(){
    if(hasObjecitive && objective.turnInLoc == building){
      return RaisedButton(
        child: Text(FlutterI18n.translate(
          context,
          "Map.turnin-true"
        )),
        onPressed: () => turnIn(),
      );
    }else{
      return RaisedButton(
        
        child: Text(FlutterI18n.translate(
          context,
          "Map.turnin-false"
        )),
        onPressed: null,
      );
    }
  }
//When the user clicks to add a new objective, open a window to let the user to select an objective
//If the user selects an objective, set it as the current objective
void selectNewObjective() async{
  var temp = await Navigator.push(context,
   MaterialPageRoute(builder: (context)=> ListObjectivesPage(context: context)));
   if(temp != null){
     hasObjecitive = true;
     objective = temp;
   }
}
//If the user has a current objective, show info about it. Otherwise, prompt the user to select one
Widget displayObjective(){
  if(hasObjecitive){
    return objective.build(context);
  }
  return Center(
    child: Column(
      children: <Widget>[
        Text("Start a new Objective!"),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: ()=>selectNewObjective(),
        ),
      ],
    ),
  );
}
//prompts the user if they want to turn in the objective. If they do, remove the current event
void turnIn() async{
    Course course = await _model.getCourseByName(objective.reward);
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
                if(course.grade + objective.gradeInc > 100){
                  course.grade = 100;
                }else{
                  course.grade +=objective.gradeInc;
                }
                //Turning in an objective changes a character's health and motivation. 
                setState(() {
                  _model.updateCourse(course);
                  //Prevent health from going above the max health
                  if(Character.currentHealth + objective.healthChange <=Character.maxHealth){
                    Character.currentHealth +=objective.healthChange;
                  }else{
                    Character.currentHealth =Character.maxHealth;
                  }
                  if(Character.currentMotivation + objective.motivationChange <=Character.maxMotivation){
                    Character.currentMotivation +=objective.motivationChange;
                  }else{
                    Character.currentMotivation =Character.maxMotivation;
                  }
                  
                  hasObjecitive = false;     
                });
                Navigator.of(this.context).pop();
                final snackBar =SnackBar(content: Text('turned in the objective!'));
                Scaffold.of(this.context).showSnackBar(snackBar);
                
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
  void openActivites() async{
    
    Objective result = await Navigator.push(context,
     MaterialPageRoute(builder: (context) =>  ActivitesPage(location:building)));
     if(result != null){
       Character.addAct(result);
     }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text( //Show the current location
            FlutterI18n.translate(
              context,
              "Map.location"
            )+" $building",
            style: TextStyle(fontWeight: FontWeight.bold),),
          displayObjective(),
          //Character stats
          Text(FlutterI18n.translate(
            context,
            "Map.stats"
          ), style: TextStyle(fontWeight: FontWeight.bold),),
          createStats(),
          turnInButton(),
          Row( //Activitities button
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:EdgeInsets.symmetric(horizontal: 8.0),
                child: RaisedButton(
                  child: Text(FlutterI18n.translate(
                    context,
                    "Map.activites"
                  )),
                  onPressed: () => openActivites(),
                ),
              ),
            ],
          ),
          MapInfo(context: context, lat: _lat, long: _long,),
        ],
      ),
    );
  }
}