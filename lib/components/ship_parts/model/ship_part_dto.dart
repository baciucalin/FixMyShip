class ShipPartDTO {
  final int id;
  final String partName;
  final double damagePercent;
  int shipPartCounter = 0;

  ShipPartDTO({this.id, this.partName, this.damagePercent});

  factory ShipPartDTO.fromJson(Map<String, dynamic> json) {
    return new ShipPartDTO(
      id: json['index'],
      partName: json['name'],
      damagePercent: json['damagePercent'],
    );
  }
}
