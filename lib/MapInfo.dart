import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapInfo extends StatefulWidget{
  MapInfo({Key key, this.title, this.context }) : super(key: key);
  final BuildContext context;
  final String title;
  @override
  _MapInfoState createState() => _MapInfoState();
}

class _MapInfoState extends State{

  FlutterMap _map;
  String _userName = 'colin-orian';
  String _account_id = 'cijucimbe000brbkt48d0dhcx';
  String _token = 'pk.eyJ1IjoiY29saW4tb3JpYW4iLCJhIjoiY2syeHNnMHo2MDBwYzNjbWR2aHMxazl0aCJ9.Iq-AqEiFitggCv909eKF-w';
  double _lat = 43.94542;
  double _long = -78.89668;
  int _zoom = 19;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          minZoom: 17.0,
          center: new LatLng(_lat, _long),
        ),
        layers: [
          TileLayerOptions(
             urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': _token,
              'id': 'mapbox.streets',
            },
          ),
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