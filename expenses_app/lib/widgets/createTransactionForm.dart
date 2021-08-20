import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTransactionForm extends StatefulWidget {
  final Function(String title, double amount, DateTime date) onSubmitted;
  final VoidCallback onClosed;

  CreateTransactionForm({
    required this.onSubmitted,
    required this.onClosed,
    Key? key,
  }) : super(key: key);

  @override
  _CreateTransactionFormState createState() => _CreateTransactionFormState();
}

class _CreateTransactionFormState extends State<CreateTransactionForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  var _date = DateTime.now();

  void onSubmit() {
    if (_title.text.isEmpty ||
        _amount.text.isEmpty ||
        double.tryParse(_amount.text) == null) return;

    widget.onSubmitted(
      _title.text,
      double.parse(_amount.text),
      _date,
    );

    _title.clear();
    _amount.clear();
  }

  void _showDatePicker() async {
    var res = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (res != null) setState(() => _date = res);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "New Transaction",
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  onPressed: widget.onClosed,
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _title,
              onSubmitted: (_) => onSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amount,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => onSubmit(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(DateFormat("dd/MM/yy").format(_date)),
                  IconButton(
                    icon: Icon(Icons.date_range_outlined),
                    color: Theme.of(context).primaryColor,
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text("Submit"),
              onPressed: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
