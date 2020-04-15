class RepairShopDTO {
  final int id, noOfReviews;
  final String name, phoneNumber;
  final double avgRating;

  RepairShopDTO(
      {this.id, this.name, this.phoneNumber, this.noOfReviews, this.avgRating});

  factory RepairShopDTO.fromJson(Map<String, dynamic> json) {
    return new RepairShopDTO(
      id: json['index'],
      name: json['name'],
      phoneNumber: json['phone'],
      avgRating: json['averageRating'],
      noOfReviews: json['numberOfReviews'],
    );
  }
}
