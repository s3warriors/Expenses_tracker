// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTxn;
  TransactionList(this.transactions, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    //adding expenses   ---->lec85 moved from main.dart
    return //finding height dynamically
        transactions.isEmpty
            ? LayoutBuilder(builder: ((context, constraints) {
                return Column(
                  children: [
                    Container(
                      child: Text(
                        'No transaction added yet!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      //as a seperator
                      height: constraints.maxHeight * 0.1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }))
            : ListView.builder(
                itemBuilder: (anyname, index) {
                  return
                      /* Card(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(13, 11, 13, 11),
                        decoration: BoxDecoration(
                            border: (Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(19, 21))),

                        margin: EdgeInsets.fromLTRB(15, 15, 22, 15),
                        // width: double.tryParse('100'),
                        // width: 60,
                        child: Text(
                          '₹${transactions[index].amount.toStringAsFixed(2)}', //string interpolation   //lec90 ---> tostringasfixed for fixed length
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              DateFormat('yyyy/mm/dd')
                                  .format(transactions[index].date),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ); */

                      //we can use its alternative
                      Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        // backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child: Text('₹${transactions[index].amount}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        ' ${(DateFormat.yMd().format(transactions[index].date))}',
                      ),
                      trailing: MediaQuery.of(context).size.width >= 400
                          ? ElevatedButton.icon(style: ButtonStyle(iconColor: MaterialStateProperty.all<Color>(
      Theme.of(context).colorScheme.error,
        ), backgroundColor: MaterialStateProperty.all<Color>(Colors.white) ),
                              onPressed: () =>
                                  deleteTxn(transactions[index].id),
                              icon: Icon(Icons.delete),
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            )
                          : IconButton(
                              onPressed: () =>
                                  deleteTxn(transactions[index].id),
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).colorScheme.error,
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
                // children: transactions.map((tx) {
                //   // return Card(child: Text(tx.title),);
                //   return
                // }).toList(),
              );
  }
}
