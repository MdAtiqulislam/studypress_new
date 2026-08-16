// To parse this JSON data, do
//
//     final resultDataModel = resultDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_question_model.dart';



QuizDataModel resultDataModelFromJson(String str) => QuizDataModel.fromJson(json.decode(str));

String resultDataModelToJson(QuizDataModel data) => json.encode(data.toJson());

class QuizDataModel {
  QuizDataModel({
    this.success,
    this.msg,
    this.quizSummery,
    this.modelQuesiton,
  });

  bool? success;
  String? msg;
  QuizSummery? quizSummery;
  List<SingleQuestionModel>? modelQuesiton;

  factory QuizDataModel.fromJson(Map<String, dynamic> json) => QuizDataModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    quizSummery: json["quizSummery"] == null ? null : QuizSummery.fromJson(json["quizSummery"]),
    modelQuesiton: json["model_quesiton"] == null ? null : List<SingleQuestionModel>.from(json["model_quesiton"]!.map((x) => SingleQuestionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "quizSummery": quizSummery == null ? null : quizSummery!.toJson(),
    "model_quesiton": modelQuesiton == null ? null : List<dynamic>.from(modelQuesiton!.map((x) => x.toJson())),
  };
}


class QuizSummery {
  QuizSummery({
    this.id,
    this.userId,
    this.chapterId,
    this.quizId,
    this.quizDate,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.marksAchieved,
  });

  int? id;
  int? userId;
  int? chapterId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  int? marksAchieved;

  factory QuizSummery.fromJson(Map<String, dynamic> json) => QuizSummery(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    chapterId: json["chapter_id"] == null ? null : json["chapter_id"],
    quizId: json["quiz_id"] == null ? null : json["quiz_id"],
    quizDate: json["quiz_date"] == null ? null : DateTime.parse(json["quiz_date"]),
    timeTaken: json["time_taken"] == null ? null : json["time_taken"],
    totalCorrect: json["total_correct"] == null ? null : json["total_correct"],
    totalWrong: json["total_wrong"] == null ? null : json["total_wrong"],
    marksAchieved: json["marks_achieved"] == null ? null : json["marks_achieved"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "chapter_id": chapterId == null ? null : chapterId,
    "quiz_id": quizId == null ? null : quizId,
    "quiz_date": quizDate == null ? null : quizDate!.toIso8601String(),
    "time_taken": timeTaken == null ? null : timeTaken,
    "total_correct": totalCorrect == null ? null : totalCorrect,
    "total_wrong": totalWrong == null ? null : totalWrong,
    "marks_achieved": marksAchieved == null ? null : marksAchieved,
  };
}


