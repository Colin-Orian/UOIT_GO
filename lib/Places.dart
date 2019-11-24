class _Point{
  double x;
  double y;
  _Point({this.x, this.y});
}


class Places{
  static List<_Point> _botLeft = [
    _Point(x: 43.929129, y: -78.934739),
  ];

  static List<_Point> _topRight = [
    _Point(x: 50.00000, y: -80.0000)
  ];
  static List<String> _places = [
    'Home'
  ];

  static String currentPlace(double lat, double long){
    for(int i = 0; i < _places.length; i ++){
      if(lat >=_botLeft[i].x && lat <= _topRight[i].x){
        return _places[i];
      }
    }
    return 'No Location';
  }
}