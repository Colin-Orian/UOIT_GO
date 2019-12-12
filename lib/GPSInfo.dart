import 'package:flutter/material.dart';
import 'package:location/location.dart';

//NOTE: THIS CLASS WAS USED FOR FINDING LOCATION OF BUILDINGS. IT ISN'T A PART OF THE APPLICATION
class GPSInfo extends StatefulWidget{

  _GPSInfoState createState() => _GPSInfoState();
}

class _GPSInfoState extends State<GPSInfo>{
  List<double> _lat = [];
  List<double> _long = [];
  Location _location;
  _GPSInfoState(){
    _location = new Location();
  }
  //get the latitude and longitude and update the lat and long
  getLocation() async{
    LocationData data = await _location.getLocation();
    setState(() {
      _lat.add(data.latitude);
      _long.add(data.longitude);  
    });
    
  }

  List<ListTile> makeList(){
    List<ListTile> result = List<ListTile>();
    for(int i = 0; i < _lat.length; i ++){
      result.add(ListTile(
        title: Text("Lat $_lat"),
        subtitle: Text("Long $_long"),
      ));
    }
    return result;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: makeList()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => getLocation(),
      ),
    );
  }
}