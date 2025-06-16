import 'package:bright_minds/core/api/end_point.dart';

class EvaluateModel {
  final bool success;
  final String message;
  final int statusCode;
  final EvaluateData data;

  EvaluateModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory EvaluateModel.fromJson(Map<String, dynamic> json) {
    return EvaluateModel(
      success: json[ApiKey.success] as bool,
      message: json[ApiKey.message] as String,
      statusCode: json[ApiKey.statusCode] as int,
      data: EvaluateData.fromJson(json[ApiKey.data] as Map<String, dynamic>),
    );
  }
}

class EvaluateData {
  final int id;
  final String title;
  final int grade;
  final int videoId;
  final List<EvaluateQuestion> questions;

  EvaluateData({
    required this.id,
    required this.title,
    required this.grade,
    required this.videoId,
    required this.questions,
  });

  factory EvaluateData.fromJson(Map<String, dynamic> json) {
    return EvaluateData(
      id: json[ApiKey.id] as int,
      title: json[ApiKey.title] as String,
      grade: json[ApiKey.grade] as int,
      videoId: json[ApiKey.videoId] as int,
      questions: (json[ApiKey.questions] as List<dynamic>)
          .map((e) => EvaluateQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EvaluateQuestion {
  final int id;
  final bool status;
  final String answer;
  final QuestionDetail question;

  EvaluateQuestion({
    required this.id,
    required this.status,
    required this.answer,
    required this.question,
  });

  factory EvaluateQuestion.fromJson(Map<String, dynamic> json) {
    return EvaluateQuestion(
      id: json[ApiKey.id] as int,
      status: json[ApiKey.status] as bool,
      answer: json[ApiKey.answer] as String,
      question: QuestionDetail.fromJson(
          json[ApiKey.question] as Map<String, dynamic>),
    );
  }
}

class QuestionDetail {
  final int id;
  final String title;
  final String type;
  final String attachmentUrl;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correctAnswer;
  final int videoId;

  QuestionDetail({
    required this.id,
    required this.title,
    required this.type,
    required this.attachmentUrl,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
    required this.videoId,
  });

  factory QuestionDetail.fromJson(Map<String, dynamic> json) {
    return QuestionDetail(
      id: json[ApiKey.id] as int,
      title: json[ApiKey.title] as String,
      type: json[ApiKey.type] as String,
      attachmentUrl: json[ApiKey.attachmentUrl] as String,
      option1: json[ApiKey.option1] as String,
      option2: json[ApiKey.option2] as String,
      option3: json[ApiKey.option3] as String,
      option4: json[ApiKey.option4] as String,
      correctAnswer: json[ApiKey.correctAnswer] as String,
      videoId: json[ApiKey.videoId] as int,
    );
  }
}
