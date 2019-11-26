class _Point{
  double x;
  double y;
  _Point({this.x, this.y});
}


class Places{
  static List<_Point> _botLeft = [
    _Point(x: 43.9443203, y: -78.8958327),
    _Point(x: 43.945397, y: -78.8958327),
    _Point(x: 43.945849, y: -78.89642),
  ];

  static List<_Point> _topRight = [
    _Point(x: 43.9447362, y: -78.8971068),
    _Point(x: 43.954133, y: -78.8959179),
    _Point(x: 43.9459111, y: -78.8960908),
  ];
  static List<String> _places = [
    'UA',
    'UL',
    'ERC',
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