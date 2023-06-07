// // ignore_for_file: prefer_const_constructors

// import './new_transactions.dart';
// import '../models/transaction.dart';
// import './transaction_list.dart';
// import 'package:flutter/material.dart';

// class UserTransactions extends StatefulWidget {
//   const UserTransactions({super.key});
  

//   @override
//   State<UserTransactions> createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {


//   void addNewTx(String txTitle, double txAmount) {


//     final newTx = Transactions(
//         id: DateTime.now.toString(),
//         amount: txAmount,
//         date: DateTime.now(),
//         title: txTitle);
//         setState(() {
          
//     _usertxn.add(newTx);
//         });
//   }
//   final List<Transactions> _usertxn = [
//     Transactions(id: 't1', amount: 69.69, date: DateTime.now(), title: 'Shoes'),
//     Transactions(id: 't2', amount: 99.31, date: DateTime.now(), title: 'Cloths')
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [NewTransactions(addNewTx), TransactionList(_usertxn)],
//     );
//   }
// }
