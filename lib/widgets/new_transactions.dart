// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addnewtxn;
  NewTransactions(this.addnewtxn);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  // this is one method fpr fetching user input
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  DateTime? _selectDate;
//  late DateTime _selectDate;

  void _submitted() {
    if (_amountcontroller.text.isEmpty) return;
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = _amountcontroller.text;
    if (enteredTitle.isEmpty ||
        double.parse(enteredAmount) <= 0 ||
        _selectDate == null) return;

    //widget.    this is a functionality provided by flutter and using this we can use method of widget class in state class
    widget.addnewtxn(
      enteredTitle,
      double.parse(enteredAmount),
      _selectDate,
    );

    Navigator.of(context).pop(); //to close after submission
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectDate = pickedDate;
        });
      }
    });
  }

//  NewTransactions({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          // height: 400,
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: (InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 20),
                )),
                // onChanged: (val) {     //method 1 for fetching user input
                //   titleInput = val;
                // },
                controller: _titlecontroller, //method 2 as mentioned above
    
                onSubmitted: (_) => _submitted(), //what should happen on submit
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(fontSize: 20),
                ),
                // onChanged: (val) {
                //   amountInput = val;
                // },
    
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitted(),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectDate == null
                            ? 'No Date Chhosen'
                            : 'Picked date : ${(DateFormat.yMd().format(_selectDate!))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Chhose date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
    
                  //double.parse(amountcontroller.text) this  will convert string to double
                  onPressed: _submitted,
                  child: Text(
                    'Add Transactions',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.color, //? ensure that labellarge :textstyle (color should have some value in texttheme
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
