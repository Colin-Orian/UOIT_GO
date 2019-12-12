class _Point{ //The x and y positions of the point
  double x;
  double y;
  _Point({this.x, this.y});
}

//Our Geocoding class. It geocodes the different buildings on the campus by making a
//bounding box around the buildings and checking if the GPS coordinates are within those boxes
class Places{

  //The bottom left and top right corners of a box around the corresponding building
  static List<_Point> _botLeft = [
    _Point(x: 43.944156, y: -78.897096), //UA
    _Point(x: 43.945420, y: -78.896484), //ERC
    _Point(x: 43.945540, y: -78.897450), //Library
  ];

  static List<_Point> _topRight = [
    _Point(x: 43.944832, y: -78.895803), //UA
    _Point(x: 43.945907, y: -78.896066), //ERC
    _Point(x: 43.946057, y: -78.897037), //Library
  ];
  static List<String> _places = [
    'UA',
    'ERC',
    'Library'
  ];

  //Go through each building and check if the current latitude and longitude is within the box.
  //Return the corresponding building if within. Return No Location otherwise
  static String currentPlace(double lat, double long){
    for(int i = 0; i < _places.length; i ++){
      if(lat >=_botLeft[i].x && lat <= _topRight[i].x
        && long >=_botLeft[i].y && long <=_topRight[i].y){
          return _places[i];
      }
    }
    return 'No Location';
  }
}