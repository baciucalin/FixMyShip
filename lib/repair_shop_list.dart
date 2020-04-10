import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shipmyfix/repair_shop_card.dart';
import 'package:shipmyfix/repair_shop_dto.dart';

class RepairShopList extends StatelessWidget {
  List<RepairShopDTO> repairShops; // RepairShop
  Function onRepairShopClicked;

//  RepairShopList({this.repairShops, this.onRepairShopClicked});
  RepairShopList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            child: TextField(
              autofocus: false,
              key: Key('searchBar'),
              decoration: InputDecoration(labelText: 'Search Shops'),
              onChanged: (txt) {
                //todo search here
              },
            ),
          ),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Checkbox(
                  checkColor: Colors.tealAccent,
                  tristate: true,
                ),
                Checkbox(
                  checkColor: Colors.tealAccent,
                  tristate: true,
                ),
                Checkbox(
                  checkColor: Colors.tealAccent,
                  tristate: true,
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RepairShopCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> loadAsset(BuildContext context) async {
    rootBundle.loadString('mock_data/repair_shops_mockJSON.json');
  }
}
