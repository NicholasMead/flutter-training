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
              "Quiz Completed ($result/$numQuestions)",
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          OutlinedButton(
              child: Text("Start Again"),
              onPressed: onReset,
              style: OutlinedButton.styleFrom(
                primary: Colors.orange,
                side: BorderSide(color: Colors.orange),
              )),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
