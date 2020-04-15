import 'package:flutter/material.dart';
import 'package:shipmyfix/components/repair_shops/model/repair_shop_dto.dart';

class RepairShopCard extends StatelessWidget {
  final RepairShopDTO repairShop;

  RepairShopCard(this.repairShop);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.teal[800],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(repairShop.name),
                Text(
                    'Rating: ${repairShop.avgRating.toStringAsFixed(2)} (${repairShop.noOfReviews})'),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.local_shipping),
            ),
          ],
        ),
      ),
    );
  }
}
