import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class MapInfo extends StatelessWidget{
  MapInfo({this.context, double lat, double long}) :  _lat = lat, _long = long;
  final double _lat;
  final double _long;
  final BuildContext context;  
  final String _token = 'pk.eyJ1IjoiY29saW4tb3JpYW4iLCJhIjoiY2syeHNnMHo2MDBwYzNjbWR2aHMxazl0aCJ9.Iq-AqEiFitggCv909eKF-w';

  @override
  Widget build(BuildContext context) {
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
  

  
  