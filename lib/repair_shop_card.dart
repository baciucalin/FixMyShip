import 'package:flutter/material.dart';
import 'package:shipmyfix/repair_shop_dto.dart';

class RepairShopCard extends StatelessWidget {
  final RepairShopDTO repairShop = null;

//  RepairShopCard(this.repairShop);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          highlightColor: Colors.tealAccent,
          onTap: () {
            print('I was tapped!');
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.access_alarm),
              ),
              Center(
                child: Text("my text"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
