// To parse this JSON data, do
//
//     final quizDataStoreResponseModel = quizDataStoreResponseModelFromJson(jsonString);

import 'dart:convert';

QuizDataStoreResponseModel quizDataStoreResponseModelFromJson(String str) => QuizDataStoreResponseModel.fromJson(json.decode(str));

String quizDataStoreResponseModelToJson(QuizDataStoreResponseModel data) => json.encode(data.toJson());

class QuizDataStoreResponseModel {
  QuizDataStoreResponseModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  Data? data;

  factory QuizDataStoreResponseModel.fromJson(Map<String, dynamic> json) => QuizDataStoreResponseModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.testId,
    this.quizId,
    this.quizDate,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.id,
  });

  int? userId;
  dynamic testId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    testId: json["test_id"],
    quizId: json["quiz_id"],
    quizDate: json["quiz_date"] == null ? null : DateTime.parse(json["quiz_date"]),
    timeTaken: json["time_taken"],
    totalCorrect: json["total_correct"],
    totalWrong: json["total_wrong"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "test_id": testId,
    "quiz_id": quizId,
    "quiz_date": quizDate?.toIso8601String(),
    "time_taken": timeTaken,
    "total_correct": totalCorrect,
    "total_wrong": totalWrong,
    "id": id,
  };
}
