// To parse this JSON data, do
//
//     final storeAnswerModel = storeAnswerModelFromJson(jsonString);

import 'dart:convert';

StoreAnswerModel storeAnswerModelFromJson(String str) => StoreAnswerModel.fromJson(json.decode(str));

String storeAnswerModelToJson(StoreAnswerModel data) => json.encode(data.toJson());

class StoreAnswerModel {
  StoreAnswerModel({
    this.userId,
    this.chapterId,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.chapterQuiz,
  });

  dynamic userId;
  dynamic chapterId;
  dynamic timeTaken;
  dynamic totalCorrect;
  dynamic totalWrong;
  List<ChapterQuiz>? chapterQuiz;

  factory StoreAnswerModel.fromJson(Map<String, dynamic> json) => StoreAnswerModel(
    userId: json["user_id"],
    chapterId: json["chapter_id"],
    timeTaken: json["time_taken"],
    totalCorrect: json["total_correct"],
    totalWrong: json["total_wrong"],
    chapterQuiz: json["chapter_quiz"] == null ? [] : List<ChapterQuiz>.from(json["chapter_quiz"]!.map((x) => ChapterQuiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "chapter_id": chapterId,
    "time_taken": timeTaken,
    "total_correct": totalCorrect,
    "total_wrong": totalWrong,
    "chapter_quiz": chapterQuiz == null ? [] : List<dynamic>.from(chapterQuiz!.map((x) => x.toJson())),
  };
}

class ChapterQuiz {
  ChapterQuiz({
    this.qid,
    this.ans,
    this.correctAns,
  });

  int? qid;
  String? ans;
  String? correctAns;

  factory ChapterQuiz.fromJson(Map<String, dynamic> json) => ChapterQuiz(
    qid: json["qid"],
    ans: json["ans"],
    correctAns: json["correct_ans"],
  );

  Map<String, dynamic> toJson() => {
    "qid": qid,
    "ans": ans,
    "correct_ans": correctAns,
  };
}
