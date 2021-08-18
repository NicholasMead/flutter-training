import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final int result;
  final int numQuestions;
  final VoidCallback onReset;

  ResultsPage({
    required this.result,
    required this.numQuestions,
    required this.onReset,
  });

  Widget build(BuildContext ctx) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text(
              "Quiz Completed (${result}/${numQuestions})",
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          RaisedButton(
            child: Text("Start Again"),
            onPressed: onReset,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
