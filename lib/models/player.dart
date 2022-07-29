class MCPlayer{
  int id;
  int points;
  String name;

  MCPlayer({
    required this.id,
    required this.points,
    required this.name,
  });

  void setPoints(int newPoints){
    points = newPoints;
  }

  String get printData => 'id: $id, point: $points, name: $name';
}