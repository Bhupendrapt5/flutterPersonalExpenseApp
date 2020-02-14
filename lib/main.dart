import 'package:expenses_app/widget/new_transaction.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widget/transcation_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(         //To set default textTheme
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
          subtitle: TextStyle(         //To set default textTheme
                    fontFamily: 'Quicksand',
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
               
        ),
        appBarTheme: AppBarTheme(         //To set Custom appBarTheme for all the appBar in our app
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 22,
                    // fontWeight: FontWeight.bold,
                  ),
                )),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', amount: 1850, title: 'New Shoes', tdate: DateTime.now()),
    Transaction(
        id: 't2', amount: 2050, title: 'Groceries', tdate: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = new Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        tdate: DateTime.now(),
        amount: txAmount);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAtNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses Manage',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAtNewTransaction(context),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Chart Data',
                    ),
                    elevation: 5,
                  ),
                ),
                TransactionList(_userTransactions)
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAtNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
