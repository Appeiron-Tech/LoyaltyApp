class AnswerModel {
  String uid = '';
  String text = '';
  String questionId = '';
  String surveyId = '';
  DateTime createdAt;

  AnswerModel({
    required this.uid,
    required this.text,
    required this.questionId,
    required this.createdAt,
    required this.surveyId,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "text": text,
        "questionId": questionId,
        "createdAt": createdAt,
        "surveyId": surveyId,
      };
}
