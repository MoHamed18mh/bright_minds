import 'package:bright_minds/core/api/end_point.dart';

class QuizModel {
  final bool success;
  final String message;
  final int statusCode;
  final QuizData data;

  QuizModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      success: json[ApiKey.success] as bool,
      message: json[ApiKey.message] as String,
      statusCode: json[ApiKey.statusCode] as int,
      data: QuizData.fromJson(json[ApiKey.data] as Map<String, dynamic>),
    );
  }
}

class QuizData {
  final int id;
  final String title;
  final int grade;
  final int videoId;
  final String? studentName;
  final List<Question> questions;

  QuizData({
    required this.id,
    required this.title,
    required this.grade,
    required this.videoId,
    required this.studentName,
    required this.questions,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      id: json[ApiKey.id] as int,
      title: json[ApiKey.title] as String,
      grade: json[ApiKey.grade] as int,
      videoId: json[ApiKey.videoId] as int,
      studentName: json[ApiKey.studentName] as String?,
      questions: (json[ApiKey.questions] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Question {
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

  Question({
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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
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
