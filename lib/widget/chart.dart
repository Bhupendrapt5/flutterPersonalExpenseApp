import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widget/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTx;

  Chart(this.recentTx);

  List<Map<String, Object>> get grpTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTx.length; i++) {
        if (recentTx[i].tdate.day == weekday.day &&
            recentTx[i].tdate.month == weekday.month &&
            recentTx[i].tdate.year == weekday.year) {
          totalSum += recentTx[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return grpTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: grpTransactionValues.map((gTx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  gTx['day'],
                  gTx['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (gTx['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
