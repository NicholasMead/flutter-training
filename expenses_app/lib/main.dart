import 'package:expenses_app/widgets/createTransactionForm.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transactionList.dart';
import 'widgets/transactionWeekChart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
        fontFamily: "OpenSans",
        //fontFamily: "Quicksand",
      ),
      home: MyHomePage(title: 'Personal Expenses'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final transactions = <Transaction>[];

  List<Transaction> get recentTransaction => transactions
      .where((t) => t.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void onNewTransaction(String title, double amount, DateTime date) {
    var newTransaction = Transaction.create(
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      transactions.add(newTransaction);
      transactions.sort((t1, t2) {
        return (t1.date.day == t2.date.day &&
                t1.date.month == t2.date.month &&
                t1.date.year == t2.date.year)
            ? t1.title.compareTo(t2.title)
            : t1.date.isAfter(t2.date)
                ? -1
                : 1;
      });
    });

    Navigator.of(context).pop();
  }

  void onCanceledTransaction() {
    Navigator.of(context).pop();
  }

  void onDeletedTransaction(TransactionId id) {
    print("ondeleted: ${id.value}");
    setState(() {
      transactions.removeWhere((tx) => tx.id.value == id.value);
    });
  }

  void startAddNewTransaction() {
    //showDialog(context: context, builder: (_) => Text("Dialog"));

    showDialog(
      context: context,
      builder: (_) => Center(
        child: Card(
          margin: EdgeInsets.all(10),
          child: CreateTransactionForm(
            onSubmitted: onNewTransaction,
            onClosed: onCanceledTransaction,
          ),
        ),
      ),
    );

    // showModalBottomSheet(
    //   context: context,
    //   builder: (_) => Column(
    //     children: [
    //       CreateTransactionForm(onSubmitted: onNewTransaction),
    //       SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
    //     ],
    //   ),
    // );
    //builder: (_) => CreateTransactionForm(onSubmitted: onNewTransaction),
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        widget.title,
        style: TextStyle(fontFamily: "OpenSans"),
      ),
      actions: [
        IconButton(
          onPressed: () => startAddNewTransaction(),
          icon: Icon(Icons.add),
        ),
      ],
    );

    var remainingHigh = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    var chartHeight = remainingHigh * .225;
    var listHight =
        remainingHigh - MediaQuery.of(context).viewInsets.bottom - chartHeight;

    return Scaffold(
      appBar: appBar,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: chartHeight,
              child: TransactionWeekChart(recentTransactions: transactions),
            ),
            Container(
              height: listHight,
              child: TransactionList(
                transactions: transactions,
                onDeletedTransaction: onDeletedTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(),
        child: Icon(Icons.add),
      ),
    );
  }
}
