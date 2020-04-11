import 'package:flutter/material.dart';
import 'package:shipmyfix/repair_shop_card.dart';
import 'package:shipmyfix/repair_shop_dto.dart';
import 'package:shipmyfix/repair_shop_list.dart';
import 'package:shipmyfix/search_widget.dart';

enum SortBy { Name, Rating, Price }

class RepairShopListRoute extends StatefulWidget {
  @override
  RepairShopListRouteState createState() => new RepairShopListRouteState();
}

class RepairShopListRouteState extends State<RepairShopListRoute> {
  Future<List<RepairShopDTO>> _repairShopsResponse;
  List<RepairShopDTO> repairShops;
  List<RepairShopDTO> repairShopsSearchResults;

  TextEditingController _textEditingController = new TextEditingController();
  SortBy _sortBy;

  @override
  void initState() {
    super.initState();
    repairShopsSearchResults = [];
    _sortBy = SortBy.Name;
    _repairShopsResponse = RepairShopList().loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SearchWidget(_textEditingController, _onSearchTextChanged),
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: buildRadio('name', SortBy.Name),
                ),
                Expanded(
                  child: buildRadio('rating', SortBy.Rating),
                ),
                Expanded(
                  child: buildRadio('price', SortBy.Price),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: _repairShopsResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  repairShops = snapshot.data;
                  return _buildListOfShops();
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRadio(String title, SortBy sortByOptions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Radio(
          value: sortByOptions,
          groupValue: _sortBy,
          onChanged: (SortBy value) {
            setState(() {
              _sortBy = value;
            });
          },
        ),
      ],
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
      _sortRepairShops(repairShopsSearchResults);

      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: repairShopsSearchResults.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return RepairShopCard(repairShopsSearchResults[index]);
        },
      );
    } else {
      _sortRepairShops(repairShops);

      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: repairShops.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return RepairShopCard(repairShops[index]);
        },
      );
    }
  }

  _sortRepairShops(List<RepairShopDTO> list) {
    switch (_sortBy) {
      case SortBy.Name:
        list.sort((a, b) {
          return a.shopName.compareTo(b.shopName);
        });
        break;
      case SortBy.Rating:
        list.sort((b, a) {
          return a.avgRating.compareTo(b.avgRating);
        });
        break;
      case SortBy.Price:
        // TODO: Handle this case.
        break;
    }
  }

  _onSearchTextChanged(String txt) {
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
