import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    // textScaleFactor tells you by how much text output in the app should be scaled

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

  List<Widget> _buildLandscapeContent(AppBar _myAppBar, Widget _txListBar) {
    return [
      Row(
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
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      _myAppBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransaction),
            )
          : _txListBar
    ];
  }

  List<Widget> _buildPortraitContent(AppBar _myAppBar, Widget _txListBar) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                _myAppBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.25,
        child: Chart(_recentTransaction),
      ),
      _txListBar
    ];
  }

  CupertinoPageScaffold _cupertinoPageScaffold(Widget _pageBody, CupertinoNavigationBar _myAppBar){
    return CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _myAppBar,
          );
  }
  
  Scaffold _scaffold(Widget _pageBody, AppBar _myAppBar){
    return Scaffold(
            appBar: _myAppBar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAtNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape = MediaQuery.of(context).orientation ==
        Orientation.landscape; //To check orientation of device

    final PreferredSizeWidget _myAppBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expenses Manage',
            ),
            trailing: GestureDetector(
              onTap: () => _startAtNewTransaction(context),
              child: Icon(CupertinoIcons.add),
            ),
          )
        : AppBar(
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

    final _pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (_isLandscape) ..._buildLandscapeContent(_myAppBar, _txListBar),
          if (!_isLandscape)
            ..._buildPortraitContent(_myAppBar,
                _txListBar), //using three dots, makes the all the element of list to be merge as one arguement
        ],
      ),
    ));

    return Platform.isIOS
        ? _cupertinoPageScaffold(_pageBody, _myAppBar)
        : _scaffold(_pageBody, _myAppBar);
  }
}
