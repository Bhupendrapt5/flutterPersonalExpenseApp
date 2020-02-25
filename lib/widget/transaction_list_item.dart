import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionListItem extends StatelessWidget {
  
  
  const TransactionListItem({
    Key key,
    @required Transaction userTransaction,
    @required Function deleteTx,
  }) : _userTransaction = userTransaction, _deleteTx = deleteTx, super(key: key);

  final Transaction _userTransaction;
  final Function _deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${_userTransaction.amount}'),
            ),
          ),
        ),
        title: Text(
          _userTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(_userTransaction.tdate),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () =>
                    _deleteTx(_userTransaction.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () =>
                    _deleteTx(_userTransaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}