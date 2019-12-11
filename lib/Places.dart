class _Point{
  double x;
  double y;
  _Point({this.x, this.y});
}

class Places{
  static List<_Point> _botLeft = [
    _Point(x: 43.944156, y: -78.897096), //UA
    _Point(x: 43.944832, y: -78.895803), //UB
    _Point(x: 43.945420, y: -78.896484), //ERC
    _Point(x: 43.945540, y: -78.897450), //Library
  ];

  static List<_Point> _topRight = [
    _Point(x: 43.944832, y: -78.895803), //UA
    _Point(x: 43.945377, y: -78.895921), //UB
    _Point(x: 43.945907, y: -78.896066), //ERC
    _Point(x: 43.946057, y: -78.897037), //Library
  ];
  static List<String> _places = [
    'UA',
    'UB',
    'ERC',
    'Library'
  ];

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