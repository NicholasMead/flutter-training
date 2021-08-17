import 'package:basic_quiz/widgets/QuestionWidget.dart';
import 'package:basic_quiz/models/question.dart';
import 'package:basic_quiz/widgets/SelectPage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentQuestionIndex = 0;
  var questions = [
    AnswerableQuestion("What is 1+1?", ["0", "1", "2", "3"], 2),
    AnswerableQuestion("What is 1-1?", ["0", "1", "2", "3"], 0),
    AnswerableQuestion("What is 1x1?", ["0", "1", "2", "3"], 1),
    AnswerableQuestion("What is 1+2?", ["0", "1", "2", "3"], 3),
  ];

  AnswerableQuestion get currentQuestion => questions[currentQuestionIndex];

  void onAnswer(int answer) =>
      setState(() => currentQuestion.answeredIndex = answer);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
        ),
        body: Column(children: [
          QuestionWidget(
            currentQuestion,
            onAnswer: onAnswer,
            answeredIndex: currentQuestion.answeredIndex,
          ),
          SelectPage(
            currentPage: currentQuestionIndex + 1,
            pageCount: questions.length,
            onPageChange: (page) =>
                setState(() => currentQuestionIndex = page - 1),
          )
        ]),
      ),
    );
  }
}

void main() => runApp(MyApp());
