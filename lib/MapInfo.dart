import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
class MapInfo extends StatefulWidget{
  MapInfo({Key key, this.title, this.context }) : super(key: key);
  final BuildContext context;
  final String title;
  @override
  _MapInfoState createState() => _MapInfoState();
}

class _MapInfoState extends State{

  FlutterMap _map;
  Location _location;
  String _userName = 'colin-orian';
  String _account_id = 'cijucimbe000brbkt48d0dhcx';
  String _token = 'pk.eyJ1IjoiY29saW4tb3JpYW4iLCJhIjoiY2syeHNnMHo2MDBwYzNjbWR2aHMxazl0aCJ9.Iq-AqEiFitggCv909eKF-w';
  double _lat = 43.94542;
  double _long = -78.89668;
  int _zoom = 19;

  _MapInfoState(){
    updateLocation();
  }
//Creates a listener that will updated the latitude and longitue each time it changes
  void updateLocation(){
    _location = new Location();
    _location.onLocationChanged().listen((LocationData currentLocation){
      setState(() {
        _lat =currentLocation.latitude;
        _long =currentLocation.longitude;  
      });      
    });
  } 
  
  @override
  Widget build(BuildContext context) {
    updateLocation();
    return Container(
      width:MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -336,
      child: FlutterMap(
        options: MapOptions(
          minZoom: 17.0,
          center: new LatLng(_lat, _long),
        ),
        layers: [
          //download and displays the map of the current lat and long from mapbox
          TileLayerOptions(
             urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': _token,
              'id': 'mapbox.streets',
            },
          ),
          //Creates a marker for the user's current location
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: LatLng(_lat, _long),
                builder: (context) => Container(
                    child: Icon(
                      Icons.person_pin,
                    )
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}