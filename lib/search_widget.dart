import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final Function _onSearchTextChanged;

  SearchWidget(this._textEditingController, this._onSearchTextChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            controller: _textEditingController,
            decoration:
                InputDecoration(hintText: 'Search', border: InputBorder.none),
            onChanged: _onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              _textEditingController.clear();
              _onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }
}
