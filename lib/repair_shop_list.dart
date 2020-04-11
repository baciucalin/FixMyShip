import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shipmyfix/repair_shop_card.dart';
import 'package:shipmyfix/repair_shop_dto.dart';

class RepairShopList extends StatefulWidget {
  @override
  RepairShopListState createState() => new RepairShopListState();
}

class RepairShopListState extends State<RepairShopList> {
  List<RepairShopDTO> repairShops;
  List<RepairShopDTO> repairShopsSearchResults;
  TextEditingController _textEditingController = new TextEditingController();

  Function onRepairShopClicked;

  RepairShopListState({this.repairShops, this.onRepairShopClicked});

  @override
  void initState() {
    super.initState();
    repairShops = [];
    repairShopsSearchResults = [];
    loadAsset(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      hintText: 'Search Shops', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _textEditingController.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(bottom: 10),
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
            child: _buildListOfShops(),
          ),
        ],
      ),
    );
  }

  Widget _buildListOfShops() {
    if (_textEditingController.text.isNotEmpty &&
        repairShopsSearchResults.isEmpty) {
      return Container(
        child: Text('No repair shops that match your search term found.'),
      );
    }

    if (repairShopsSearchResults.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: repairShopsSearchResults.length,
        itemBuilder: (context, index) {
          return RepairShopCard(repairShopsSearchResults[index]);
        },
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: repairShops.length,
        itemBuilder: (context, index) {
          return RepairShopCard(repairShops[index]);
        },
      );
    }
  }

  Future<List<RepairShopDTO>> loadAsset(BuildContext context) async {
    String data = await rootBundle
        .loadString('assets/mock_data/repair_shops_mockJSON.json');
    var jsonResult = json.decode(data);
    setState(() {
      mapRepairShopsFromJson(jsonResult);
    });
  }

  List<RepairShopDTO> mapRepairShopsFromJson(List<dynamic> response) {
    response.forEach((item) {
      repairShops.add(RepairShopDTO.fromJson(item));
    });
    return repairShops;
  }

  onSearchTextChanged(String txt) {
    repairShopsSearchResults.clear();
    if (txt.isEmpty) {
      setState(() {});
      return;
    }

    repairShops.forEach((item) {
      if (item.shopName.toLowerCase().contains(txt.toLowerCase()))
        repairShopsSearchResults.add(item);
    });

    setState(() {});
  }
}
