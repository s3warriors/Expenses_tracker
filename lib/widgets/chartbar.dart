// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Chart_bar extends StatelessWidget {
  // const Chart_bar({super.key});

  final String label;
  final double spendingAmount;
  final double spendingPofTotal;

  Chart_bar(this.label, this.spendingAmount, this.spendingPofTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints) {
return  Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 2),
            padding: EdgeInsets.all(2),
            height: Constraints.maxHeight*0.15,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: FittedBox(
                child: Text(
              '₹${spendingAmount.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ))),
        SizedBox(
          height: Constraints.maxHeight*0.05,
        ),
        SizedBox(
          height: Constraints.maxHeight*0.6,
          width: 12,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
            ),

//for Creating a widget that sizes its child to a fraction of the total available space.
            FractionallySizedBox(
              heightFactor: spendingPofTotal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withAlpha(255),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: Constraints.maxHeight*0.05,
        ),
        SizedBox(height: Constraints.maxHeight*0.15,
          child: Text(label)),
      ],
    );
    });
   
  }
}
