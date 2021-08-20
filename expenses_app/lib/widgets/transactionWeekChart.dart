import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionWeekChart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const TransactionWeekChart({
    required this.recentTransactions,
    Key? key,
  }) : super(key: key);

  List<WeekdayAmount> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: 6 - index));

      double amount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          amount += recentTransactions[i].amount;
        }
      }

      return WeekdayAmount(
        weekday: DateFormat("E").format(weekday).substring(0, 1),
        amount: amount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var total =
        recentTransactions.fold<double>(0.0, (val, tx) => val + tx.amount);

    return Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: groupedTransactions
                .map(
                  (t) => Flexible(
                    fit: FlexFit.tight,
                    child: TransactionWeekChartBar(
                      label: t.weekday,
                      spendingAmount: t.amount,
                      spendingPct: t.amount / total,
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }
}

class TransactionWeekChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;

  const TransactionWeekChartBar({
    required this.label,
    required this.spendingAmount,
    required this.spendingPct,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FittedBox(
          child: Text("£${spendingAmount.toStringAsFixed(0)}"),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              spendingPct > 0
                  ? FractionallySizedBox(
                      heightFactor: spendingPct,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}

class WeekdayAmount {
  final String weekday;
  final double amount;

  const WeekdayAmount({
    required this.weekday,
    required this.amount,
  });
}
