import 'package:flutter/material.dart';


import '../models/transaction.dart';
import './transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (bCtx, constraints) {
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
              return TransactionListItem(userTransaction: _userTransactions[index], deleteTx: _deleteTx);
            },

            itemCount: _userTransactions.length,
            //Column widget takes list as input
            //hence instead of passing Widget list, we are passing Transaction list.
            // children: _userTransactions.map((tx) {
            // }).toList(),
          );
  }
}

