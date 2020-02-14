import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    // Adding new Transaction
    widget.addTx(enteredTitle, enteredAmount);

    //To close the modal bottom sheet after adding new Tx
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              // onChanged: (val) => titleInput=val,           //Anonymous function, we can use named function too
              onSubmitted: (_) =>
                  submitData(), // Underscore is used coz onSubmit requires a funtion with String parameter, and SubmitData is funtion with no para
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
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                cursorColor: Theme.of(context).accentColor),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
