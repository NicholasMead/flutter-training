import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../layout/measuredBox.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(TransactionId id) onDeletedTransaction;

  TransactionList({
    required this.transactions,
    required this.onDeletedTransaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: transactions.isEmpty
          ? NoTransactionView()
          : TransactionListView(
              transactions: transactions,
              onDeletedTransaction: onDeletedTransaction,
            ),
    );
  }
}

class TransactionListView extends StatelessWidget {
  final Function(TransactionId id) onDeletedTransaction;
  final scrollController = ScrollController();

  TransactionListView({
    Key? key,
    required this.transactions,
    required this.onDeletedTransaction,
  }) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        var tx = transactions[index];
        return AnimatedTransactionTile(
          tx: tx,
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDeletedTransaction(tx.id),
              padding: EdgeInsets.all(0),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedTransactionTile extends StatefulWidget {
  const AnimatedTransactionTile({
    Key? key,
    required this.tx,
    this.actions,
  }) : super(key: key);

  final Transaction tx;
  final List<Widget>? actions;

  @override
  _AnimatedTransactionTileState createState() =>
      _AnimatedTransactionTileState();
}

class _AnimatedTransactionTileState extends State<AnimatedTransactionTile> {
  bool _showIcons = false;
  Size? _actionSize;

  Widget build(BuildContext context) {
    var actions = MeasuredBox(
      onRenderedSize: (size) => setState(() {
        _actionSize = size;
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: widget.actions!,
      ),
    );

    var stack = Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        actions,
        Row(
          children: [
            Expanded(
              child: _actionSize == null
                  ? Container(
                      decoration: BoxDecoration(color: Colors.red),
                    )
                  : TransactionTile(tx: widget.tx),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _showIcons && _actionSize != null ? _actionSize!.width : 0,
            ),
          ],
        ),
      ],
    );

    return GestureDetector(
      onLongPress: () => setState(() => _showIcons = !_showIcons),
      onHorizontalDragUpdate: (details) =>
          setState(() => _showIcons = details.delta.dx < 0),
      child: stack,
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.tx,
  }) : super(key: key);

  final Transaction tx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          child: CircleAvatar(
            radius: 30,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "??${tx.amount.toStringAsFixed(2)}".replaceAll(".00", ""),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          DateFormat("dd/MM/yy").format(tx.date),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class NoTransactionView extends StatelessWidget {
  const NoTransactionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "No transactions yet",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 150,
          child: Image.asset("assets/images/waiting.png"),
        )
      ],
    );
  }
}
