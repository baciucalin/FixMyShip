import 'package:flutter/material.dart';
import 'package:shipmyfix/repair_shop_dto.dart';

class RepairShopCard extends StatelessWidget {
  final RepairShopDTO repairShop;

  RepairShopCard(this.repairShop);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.teal[800],
      child: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          highlightColor: Colors.tealAccent,
          splashColor: Colors.tealAccent,
          onTap: () {
            print('I was tapped!');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(repairShop.shopName),
                  Text(repairShop.avgRating.toStringAsFixed(2) +
                      ' (${repairShop.noOfReviews})'),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.access_alarm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
