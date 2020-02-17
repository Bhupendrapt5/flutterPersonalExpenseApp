import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
          builder: (bCtx, constraints){
            return Column(
            children: <Widget>[
              Text('No transaction added yet'),
              SizedBox(
                //To add sapce between text and image. we can provide width as well
                height: 10,
              ),
              Container(
                  height: constraints.maxHeight * 0.4,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          );
          },
        ) 
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${_userTransactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_userTransactions[index].tdate),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTx(_userTransactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },

            itemCount: _userTransactions.length,
            //Column widget takes list as input
            //hence instead of passing Widget list, we are passing Transaction list.
            // children: _userTransactions.map((tx) {
            // }).toList(),
          );
  }
}
