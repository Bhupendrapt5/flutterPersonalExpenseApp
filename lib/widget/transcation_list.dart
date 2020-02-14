import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.all(3),
            elevation: 5,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    _userTransactions[index].amount.toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      DateFormat.yMMMd().format(_userTransactions[index].tdate),
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                )
              ],
            ),
          );
        },

        itemCount: _userTransactions.length,
        //Column widget takes list as input
        //hence instead of passing Widget list, we are passing Transaction list.
        // children: _userTransactions.map((tx) {
        // }).toList(),
      ),
    );
  }
}
