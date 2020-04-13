import 'dart:convert';

import 'package:shipmyfix/ship_part_dto.dart';
import 'package:flutter/services.dart' show rootBundle;

class ShipPartList {
  List<ShipPartDTO> _shipParts = [];

  Future<List<ShipPartDTO>> loadAssets() async {
    String data = await rootBundle
        .loadString('assets/mock_data/ship_parts_mockJSON.json');
    var jsonResult = json.decode(data);

    return _mapShipPartsFromJson(jsonResult);
  }

  List<ShipPartDTO> _mapShipPartsFromJson(List<dynamic> response) {
    response.forEach((item) {
      _shipParts.add(ShipPartDTO.fromJson(item));
    });
    return _shipParts;
  }
}
