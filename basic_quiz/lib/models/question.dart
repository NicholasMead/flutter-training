class Question {
  String _question;
  List<String> _answers;
  int _correctAnswerIndex;

  Question(this._question, this._answers, this._correctAnswerIndex) {
    if (_correctAnswerIndex < 0 || _correctAnswerIndex >= _answers.length)
      throw RangeError(
          "Correct answer index must be in range of supplied answers");
  }

  String get question => _question;
  List<String> get answers => _answers;
  int get correctAnswerIndex => _correctAnswerIndex;
}

class AnswerableQuestion extends Question {
  int _answeredIndex = -1;

  AnswerableQuestion(
      String question, List<String> answers, int correctAnswerIndex)
      : super(question, answers, correctAnswerIndex);

  bool get isAnsered => _answeredIndex != -1;
  int get answeredIndex => _answeredIndex;

  set answeredIndex(index) =>
      _answeredIndex = (index >= 0 || index < this._correctAnswerIndex)
          ? index
          : throw RangeError("Answered index is out of range");
}
