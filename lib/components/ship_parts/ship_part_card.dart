import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:shipmyfix/components/ship_parts/model/ship_part_dto.dart';

class ShipPartCard extends StatefulWidget {
  final ShipPartDTO shipPart;

  ShipPartCard(this.shipPart);

  @override
  ShipPartCardState createState() => ShipPartCardState();
}

class ShipPartCardState extends State<ShipPartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.shipPart.shipPartCounter == 0
            ? Colors.grey
            : Colors.teal[800],
      ),
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.shipPart.partName),
            ),
            Counter(
              initialValue: widget.shipPart.shipPartCounter,
              minValue: 0,
              maxValue: 10,
              step: 1,
              decimalPlaces: 0,
              onChanged: (value) {
                setState(() {
                  widget.shipPart.shipPartCounter = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
