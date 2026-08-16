// To parse this JSON data, do
//
//     final dashBoardDataModel = dashBoardDataModelFromJson(jsonString);

import 'dart:convert';

DashBoardDataModel dashBoardDataModelFromJson(String str) => DashBoardDataModel.fromJson(json.decode(str));

String dashBoardDataModelToJson(DashBoardDataModel data) => json.encode(data.toJson());

class DashBoardDataModel {
  DashBoardDataModel({
    this.success,
    this.msg,
    this.whatHappenedToday,
    this.quoteOfTheDay,
    this.categoryPerformancesProgress,
    this.userGrades,
  });

  bool? success;
  String? msg;
  List<WhatHappenedToday>? whatHappenedToday;
  QuoteOfTheDay? quoteOfTheDay;
  List<CategoryPerformancesProgress>? categoryPerformancesProgress;
  List<UserGrade>? userGrades;

  factory DashBoardDataModel.fromJson(Map<String, dynamic> json) => DashBoardDataModel(
    success: json["success"],
    msg: json["msg"],
    whatHappenedToday: json["what_happened_today"] == null ? [] : List<WhatHappenedToday>.from(json["what_happened_today"]!.map((x) => WhatHappenedToday.fromJson(x))),
    quoteOfTheDay: json["quote_of_the_day"] == null ? null : QuoteOfTheDay.fromJson(json["quote_of_the_day"]),
    categoryPerformancesProgress: json["category_performances_progress"] == null ? [] : List<CategoryPerformancesProgress>.from(json["category_performances_progress"]!.map((x) => CategoryPerformancesProgress.fromJson(x))),
    userGrades: json["userGrades"] == null ? [] : List<UserGrade>.from(json["userGrades"]!.map((x) => UserGrade.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "what_happened_today": whatHappenedToday == null ? [] : List<dynamic>.from(whatHappenedToday!.map((x) => x.toJson())),
    "quote_of_the_day": quoteOfTheDay?.toJson(),
    "category_performances_progress": categoryPerformancesProgress == null ? [] : List<dynamic>.from(categoryPerformancesProgress!.map((x) => x.toJson())),
    "userGrades": userGrades == null ? [] : List<dynamic>.from(userGrades!.map((x) => x.toJson())),
  };
}

class CategoryPerformancesProgress {
  CategoryPerformancesProgress({
    this.id,
    this.name,
    this.progress,
    this.subjectPerformances,
  });

  int? id;
  String? name;
  List<Progress>? progress;
  List<SubjectPerformance>? subjectPerformances;

  factory CategoryPerformancesProgress.fromJson(Map<String, dynamic> json) => CategoryPerformancesProgress(
    id: json["id"],
    name: json["name"],
    progress: json["progress"] == null ? [] : List<Progress>.from(json["progress"]!.map((x) => Progress.fromJson(x))),
    subjectPerformances: json["subject_performances"] == null ? [] : List<SubjectPerformance>.from(json["subject_performances"]!.map((x) => SubjectPerformance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "progress": progress == null ? [] : List<dynamic>.from(progress!.map((x) => x.toJson())),
    "subject_performances": subjectPerformances == null ? [] : List<dynamic>.from(subjectPerformances!.map((x) => x.toJson())),
  };
}

class Progress {
  Progress({
    this.subjectId,
    this.chapterId,
    this.progress,
    this.subject,
    this.chapter,
  });

  int? subjectId;
  int? chapterId;
  int? progress;
  Category? subject;
  Category? chapter;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
    subjectId: json["subject_id"],
    chapterId: json["chapter_id"],
    progress: json["progress"],
    subject: json["subject"] == null ? null : Category.fromJson(json["subject"]),
    chapter: json["chapter"] == null ? null : Category.fromJson(json["chapter"]),
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "chapter_id": chapterId,
    "progress": progress,
    "subject": subject?.toJson(),
    "chapter": chapter?.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.groupId,
    this.parentId,
    this.serial,
    this.display,
    this.examSerial,
  });

  int? id;
  String? name;
  int? groupId;
  int? parentId;
  int? serial;
  int? display;
  int? examSerial;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    groupId: json["group_id"],
    parentId: json["parent_id"],
    serial: json["serial"],
    display: json["display"],
    examSerial: json["exam_serial"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "group_id": groupId,
    "parent_id": parentId,
    "serial": serial,
    "display": display,
    "exam_serial": examSerial,
  };
}

class SubjectPerformance {
  SubjectPerformance({
    this.subjectId,
    this.categoryId,
    this.performance,
    this.subject,
  });

  int? subjectId;
  int? categoryId;
  int? performance;
  Category? subject;

  factory SubjectPerformance.fromJson(Map<String, dynamic> json) => SubjectPerformance(
    subjectId: json["subject_id"],
    categoryId: json["category_id"],
    performance: json["performance"],
    subject: json["subject"] == null ? null : Category.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "category_id": categoryId,
    "performance": performance,
    "subject": subject?.toJson(),
  };
}

class QuoteOfTheDay {
  QuoteOfTheDay({
    this.id,
    this.details,
    this.author,
    this.attachmentId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? details;
  String? author;
  dynamic attachmentId;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory QuoteOfTheDay.fromJson(Map<String, dynamic> json) => QuoteOfTheDay(
    id: json["id"],
    details: json["details"],
    author: json["author"],
    attachmentId: json["attachment_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated-by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details,
    "author": author,
    "attachment_id": attachmentId,
    "created_by": createdBy,
    "updated-by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class UserGrade {
  UserGrade({
    this.id,
    this.userId,
    this.categoryId,
    this.userGrade,
    this.createdAt,
    this.updatedAt,
    this.score,
    this.categoryName,
    this.inEnrollment,
    this.category,
  });

  int? id;
  int? userId;
  int? categoryId;
  int? userGrade;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? score;
  String? categoryName;
  bool? inEnrollment;
  Category? category;

  factory UserGrade.fromJson(Map<String, dynamic> json) => UserGrade(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    userGrade: json["user_grade"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    score: json["score"],
    categoryName: json["category_name"],
    inEnrollment: json["in_enrollment"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "user_grade": userGrade,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "score": score,
    "category_name": categoryName,
    "in_enrollment": inEnrollment,
    "category": category?.toJson(),
  };
}

class WhatHappenedToday {
  WhatHappenedToday({
    this.id,
    this.title,
    this.details,
    this.photo,
    this.happeningDate,
    this.display,
  });

  int? id;
  String? title;
  String? details;
  String? photo;
  DateTime? happeningDate;
  int? display;

  factory WhatHappenedToday.fromJson(Map<String, dynamic> json) => WhatHappenedToday(
    id: json["id"],
    title: json["title"],
    details: json["details"],
    photo: json["photo"],
    happeningDate: json["happening_date"] == null ? null : DateTime.parse(json["happening_date"]),
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "details": details,
    "photo": photo,
    "happening_date": happeningDate?.toIso8601String(),
    "display": display,
  };
}
