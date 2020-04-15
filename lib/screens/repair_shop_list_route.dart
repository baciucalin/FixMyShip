import 'package:flutter/material.dart';
import 'package:shipmyfix/components/repair_shops/model/repair_shop_dto.dart';
import 'package:shipmyfix/components/repair_shops/repair_shop_list.dart';
import 'package:shipmyfix/search_widget.dart';
import 'package:shipmyfix/searchable_listview.dart';

enum SortBy { Name, Rating, Price }

class RepairShopListRoute extends StatefulWidget {
  @override
  RepairShopListRouteState createState() => new RepairShopListRouteState();
}

class RepairShopListRouteState extends State<RepairShopListRoute> {
  Future<List<RepairShopDTO>> _repairShopsResponse;
  List<RepairShopDTO> _repairShops;
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
                  _repairShops = snapshot.data;
                  return SearchableListView(
                      _repairShops,
                      _textEditingController,
                      ListCardType.REPAIR_SHOP,
                      _sortRepairShops(_repairShops));
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

  _sortRepairShops(List<RepairShopDTO> list) {
    switch (_sortBy) {
      case SortBy.Name:
        list.sort((a, b) {
          return a.name.compareTo(b.name);
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
    setState(() {});
  }
}
