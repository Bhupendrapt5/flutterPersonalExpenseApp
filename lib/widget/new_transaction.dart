
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // Adding new Transaction
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    //To close the modal bottom sheet after adding new Tx
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10 //ViewInsets propertie gives us how much is laping into view
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                // onChanged: (val) => titleInput=val,           //Anonymous function, we can use named function too
                onSubmitted: (_) =>
                    _submitData(), // Underscore is used coz onSubmit requires a funtion with String parameter, and _submitData is funtion with no para
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                cursorColor: Theme.of(context).accentColor,
              ),
              TextField(
                  // onChanged: (val){                   //anonymous function,  we can use named function too
                  //     amountInput = val;
                  // },
                  onSubmitted: (_) => _submitData(),
                  keyboardType:
                      TextInputType.number, //To show only numbers on keyboard
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  cursorColor: Theme.of(context).accentColor),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked date : ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                onPressed: _submitData,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
