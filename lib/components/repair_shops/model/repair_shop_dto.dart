class RepairShopDTO {
  final int id, noOfReviews;
  final String shopName, phoneNumber;
  final double avgRating;

  RepairShopDTO(
      {this.id,
      this.shopName,
      this.phoneNumber,
      this.noOfReviews,
      this.avgRating});

  factory RepairShopDTO.fromJson(Map<String, dynamic> json) {
    return new RepairShopDTO(
      id: json['index'],
      shopName: json['name'],
      phoneNumber: json['phone'],
      avgRating: json['averageRating'],
      noOfReviews: json['numberOfReviews'],
    );
  }
}
