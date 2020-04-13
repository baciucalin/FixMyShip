import 'dart:convert';

import 'package:shipmyfix/components/repair_shops/model/repair_shop_dto.dart';
import 'package:flutter/services.dart' show rootBundle;

class RepairShopList {
  List<RepairShopDTO> _repairShops = [];

  Future<List<RepairShopDTO>> loadAssets() async {
    String data = await rootBundle
        .loadString('assets/mock_data/repair_shops_mockJSON.json');
    var jsonResult = json.decode(data);

    return _mapRepairShopsFromJson(jsonResult);
  }

  List<RepairShopDTO> _mapRepairShopsFromJson(List<dynamic> response) {
    response.forEach((item) {
      _repairShops.add(RepairShopDTO.fromJson(item));
    });
    return _repairShops;
  }
}
