import 'package:flutter/material.dart';
import 'package:shipmyfix/components/repair_shops/repair_shop_card.dart';
import 'package:shipmyfix/components/ship_parts/ship_part_card.dart';

enum ListCardType { REPAIR_SHOP, SHIP_PART }

class SearchableListView extends StatefulWidget {
  final ListCardType listCardType;

  final List _initialList;
  List _searchResults = List();

  final TextEditingController _textEditingController;
  final Function sortList;

  SearchableListView(
      this._initialList, this._textEditingController, this.listCardType,
      [this.sortList]);

  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  @override
  Widget build(BuildContext context) {
    _onSearchTextChanged(widget._textEditingController.text);
    if (widget._initialList != null) {
      return _buildListOfParts();
    }
    return Container();
  }

  Widget _buildListOfParts() {
    if (widget._textEditingController.text.isNotEmpty &&
        widget._searchResults.isEmpty) {
      return Container(
        child: Text('No elements that match your search term found.'),
      );
    }
    return _createListView(widget._searchResults.isNotEmpty);
  }

  _createListView(bool fromSearchResults) {
    return ListView.separated(
      padding: const EdgeInsets.all(3.0),
      shrinkWrap: true,
      itemCount: fromSearchResults
          ? widget._searchResults.length
          : widget._initialList.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        if (widget.sortList != null) widget.sortList(widget._initialList);
        return fromSearchResults
            ? _createListCard(widget.listCardType, widget._searchResults[index])
            : _createListCard(widget.listCardType, widget._initialList[index]);
      },
    );
  }

  _createListCard(ListCardType type, dynamic listItem) {
    switch (type) {
      case ListCardType.REPAIR_SHOP:
        return RepairShopCard(listItem);
      case ListCardType.SHIP_PART:
        return ShipPartCard(listItem);
    }
  }

  _onSearchTextChanged(String txt) {
    if (widget._searchResults != null) {
      widget._searchResults.clear();
      if (txt.isEmpty) {
        setState(() {});
        return;
      }

      setState(() {
        widget._initialList.forEach((item) {
          if (item.name.toLowerCase().contains(txt.toLowerCase()))
            widget._searchResults.add(item);
        });
      });
    }
  }
}
