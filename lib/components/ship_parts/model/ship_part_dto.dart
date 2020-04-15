class ShipPartDTO {
  final int id;
  final String name;
  final double damagePercent;
  int shipPartCounter = 0;

  ShipPartDTO({this.id, this.name, this.damagePercent});

  factory ShipPartDTO.fromJson(Map<String, dynamic> json) {
    return new ShipPartDTO(
      id: json['index'],
      name: json['name'],
      damagePercent: json['damagePercent'],
    );
  }
}
