// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:expenses_tracker/widgets/chartbar.dart';
import 'package:intl/intl.dart';

import 'package:expenses_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
//  Chart({super.key});\
  final List<Transactions> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get grouptransactionvalues {
    return List.generate(7, (index) {
      final weekdays = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekdays.day &&
            recentTransaction[i].date.month == weekdays.month &&
            recentTransaction[i].date.year == weekdays.year) {
          totalsum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekdays).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  get maxSpending {
    return grouptransactionvalues.fold(0.0, (sum, items) {
      return sum + (items['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(grouptransactionvalues);
    return Card(
      
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Container(padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color:Theme.of(context).primaryColorLight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grouptransactionvalues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chart_bar(
                  data['day'].toString(),
                  double.parse((data['amount']).toString()),
                maxSpending==0.0?0.0:  (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
