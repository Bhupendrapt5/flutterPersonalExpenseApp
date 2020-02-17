import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widget/transcation_list.dart';
import './widget/chart.dart';
import './widget/new_transaction.dart';

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
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                //To set default textTheme
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TextStyle(
                //To set default textTheme
                fontFamily: 'Quicksand',
                fontSize: 15,
                // fontWeight: FontWeight.bold,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),

        appBarTheme: AppBarTheme(
            //To set Custom appBarTheme for all the appBar in our app
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
    //   Transaction(
    //       id: 't1', amount: 1850, title: 'New Shoes', tdate: DateTime.now()),
    //   Transaction(
    //       id: 't2', amount: 2050, title: 'Groceries', tdate: DateTime.now()),
  ];

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = new Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        tdate: selectedDate,
        amount: txAmount);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAtNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        //To create modal bottom sheet
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String txId) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == txId);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.tdate.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;     //To check orientation of device 

    final _myAppBar = AppBar(
      title: Text(
        'Expenses Manage',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAtNewTransaction(context),
        ),
      ],
    );

    final _txListBar = Container(
      height: (MediaQuery.of(context).size.height -
              _myAppBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.75,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: _myAppBar,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (_isLandscape) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show Chart"),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(
                            () {
                              _showChart = val;
                            },
                          );
                        })
                  ],
                ),
                if(!_isLandscape) Container(
                        height: (MediaQuery.of(context).size.height -
                                _myAppBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.25,
                        child: Chart(_recentTransaction),
                      ),
                if(!_isLandscape) _txListBar,    
                if(_isLandscape)  
               _showChart? Container(
                        height: (MediaQuery.of(context).size.height -
                                _myAppBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(_recentTransaction),
                      )
                    :_txListBar,
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
