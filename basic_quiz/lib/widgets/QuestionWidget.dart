import 'package:basic_quiz/models/question.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Question _question;
  final ValueChanged<int> onAnswer;
  int answeredIndex = -1;

  QuestionWidget(
    this._question, {
    required this.onAnswer,
    this.answeredIndex = -1,
  });

  // set onAnswer(Function(int) callback) => onAnswer = callback;

  Widget build(buildContext) {
    var answerButtons = <Widget>[];

    for (var x = 0; x < _question.answers.length; x++) {
      var button = RaisedButton(
          child: Text(_question.answers[x]),
          onPressed: () => onAnswer(x),
          color: answeredIndex != x ? Colors.blueGrey : Colors.blue);
      answerButtons.add(Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        child: button,
      ));
    }

    return Column(children: <Widget>[
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          _question.question,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
      ...answerButtons,
    ]);
  }
}
