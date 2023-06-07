// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';

import './widgets/chart.dart';

import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  //here we r trying to restrict the landscape orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Expenses Tracker',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromRGBO(50, 17, 13, 1),
        ),
//
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'Opensans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              labelLarge: TextStyle(color: Colors.white),
            ),

        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
          color: Colors.deepPurple, // Set the app bar color here
        ),
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _showchart = false;

class _MyHomePageState extends State<MyHomePage> {
  // String? titleInput;

  final List<Transactions> _userTransactions = [
    Transactions(
        id: 't1',
        amount: 19000.01,
        date: DateTime.now(),
        title: 'Refrigerator'),
    Transactions(
        id: 't2',
        amount: 19999.99,
        date: DateTime.now(),
        title: 'Washing Machine'),
    Transactions(
        id: 't1',
        amount: 19000.01,
        date: DateTime.now(),
        title: 'Refrigerator'),
    Transactions(
        id: 't2',
        amount: 19999.99,
        date: DateTime.now(),
        title: 'Washing Machine')
  ];

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startaddnewtransactions(BuildContext contx) {
    showModalBottomSheet(
      context: contx,
      builder: (context) => GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransactions(_addNewTransaction)),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }




  @override
  Widget build(BuildContext context) {
     final mediaQuery = MediaQuery.of(context);
    final islandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
        'Expenses Tracker',
      ),
      actions: [
        IconButton(
            onPressed: () => _startaddnewtransactions(context),
            icon: Icon(Icons.add)),
      ],
    );

    final txlistWidget = SizedBox(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appbar,
      body:
          //method 1 for scrollable list----->singlechildscrollview
          // SingleChildScrollView(
          //   child: Column(

          //method 2 for scrollable list---->listview
          ListView(
        //3rd method for long list with better performance --->listview.builder      see in transaction_list

        // mainAxisAlignment: MainAxisAlignment .center, //this is how we can align column and row
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //adding switch button

          if (islandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                Switch.adaptive(
                 activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    })
              ],
            ),

          //adding chart
          //if we are not in landscape mode
          if (!islandscape)
            SizedBox(
              //we can use container also
              width: double.infinity,
              child: SizedBox(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3, //here we r reducing extra height of appbar and status bar
                  child: Chart(_recentTransactions)),
            ),
          if (!islandscape) txlistWidget,

          //if we are  in landscape mode
          if (islandscape)
            _showchart
                ? SizedBox(
                    //we can use container also
                    width: double.infinity,
                    child: SizedBox(
                        height: (mediaQuery.size.height -
                                appbar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7, //here we r reducing extra height of appbar and status bar
                        child: Chart(_recentTransactions)),
                  )
                : txlistWidget,

          //adding  input widget

          //adding expenses   ---->lec85 moved in transaction list.dart
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startaddnewtransactions(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
