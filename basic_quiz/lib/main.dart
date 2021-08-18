import 'package:basic_quiz/models/question.dart';
import 'package:basic_quiz/widgets/QuestionWidget.dart';
import 'package:basic_quiz/widgets/ResultsPage.dart';
import 'package:basic_quiz/widgets/SelectPage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? result;
  var currentQuestionIndex = 0;
  static final questions = [
    AnswerableQuestion("What is 1+1?", ["0", "1", "2", "3"], 2),
    AnswerableQuestion("What is 1-1?", ["0", "1", "2", "3"], 0),
    AnswerableQuestion("What is 1x1?", ["0", "1", "2", "3"], 1),
    AnswerableQuestion("What is 1+2?", ["0", "1", "2", "3"], 3),
  ];

  AnswerableQuestion get currentQuestion => questions[currentQuestionIndex];

  int get remainingQuestions => questions.where((q) => !q.isAnsered).length;

  void onAnswer(int answer) =>
      setState(() => currentQuestion.answeredIndex = answer);

  void onSubmit() => setState(() {
        result = questions
            .where((q) => q.correctAnswerIndex == q.answeredIndex)
            .length;
      });

  void onReset() => setState(() {
        questions.forEach((q) => q.reset());
        currentQuestionIndex = 0;
        result = null;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(result == null
                ? "Question ${currentQuestionIndex + 1}"
                : "Math Quiz"),
          ),
          body: result == null
              ? Column(children: [
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
                  ),
                  Visibility(
                    child: RaisedButton(
                      child: Text("Submit"),
                      onPressed: onSubmit,
                    ),
                    visible: remainingQuestions == 0,
                  )
                ])
              : ResultsPage(
                  result: result!,
                  numQuestions: questions.length,
                  onReset: onReset,
                )),
    );
  }
}

void main() => runApp(MyApp());
