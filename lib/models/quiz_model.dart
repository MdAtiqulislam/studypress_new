// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_question_model.dart';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    this.success,
    this.msg,
    this.data,
    this.totalRow,
  });

  bool? success;
  String? msg;
  List<SingleQuestionModel>? data;
  int? totalRow;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<SingleQuestionModel>.from(json["data"]!.map((x) => SingleQuestionModel.fromJson(x))),
    totalRow: json["total_row"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data == null ? [] : List<SingleQuestionModel>.from(data!.map((x) => x.toJson())),
    "total_row": totalRow,
  };
}

/*class Datum {
  Datum({
    this.id,
    this.examName,
    this.subject,
    this.chapterGroup,
    this.chapter,
    this.question,
    this.hints,
    this.insertedFromIp,
    this.questionBy,
    this.display,
    this.isPrev,
    this.options,
    this.hasParagraph,
    this.questionGrade,
    this.questionSource,
    this.tags,
    this.period,
    this.isChangeable,
    this.createdAt,
    this.updatedAt,
    this.expiredDate,
    this.hitCount,
    this.mistakeCount,
    this.status,
  });

  int? id;
  ExamName? examName;
  String? subject;
  dynamic chapterGroup;
  dynamic chapter;
  String? question;
  String? hints;
  String? insertedFromIp;
  int? questionBy;
  int? display;
  dynamic isPrev;
  String? options;
  int? hasParagraph;
  dynamic questionGrade;
  dynamic questionSource;
  dynamic tags;
  int? period;
  int? isChangeable;
  DateTime? createdAt;
  UpdatedAt? updatedAt;
  dynamic expiredDate;
  int? hitCount;
  int? mistakeCount;
  int? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    examName: examNameValues.map[json["exam_name"]]!,
    subject: json["subject"],
    chapterGroup: json["chapter_group"],
    chapter: json["chapter"],
    question: json["question"],
    hints: json["hints"],
    insertedFromIp: json["inserted_from_ip"],
    questionBy: json["question_by"],
    display: json["display"],
    isPrev: json["is_prev"],
    options: json["options"],
    hasParagraph: json["has_paragraph"],
    questionGrade: json["question_grade"],
    questionSource: json["question_source"],
    tags: json["tags"],
    period: json["period"],
    isChangeable: json["is_changeable"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: updatedAtValues.map[json["updated_at"]]!,
    expiredDate: json["expired_date"],
    hitCount: json["hit_count"],
    mistakeCount: json["mistake_count"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_name": examNameValues.reverse[examName],
    "subject": subject,
    "chapter_group": chapterGroup,
    "chapter": chapter,
    "question": question,
    "hints": hints,
    "inserted_from_ip": insertedFromIp,
    "question_by": questionBy,
    "display": display,
    "is_prev": isPrev,
    "options": options,
    "has_paragraph": hasParagraph,
    "question_grade": questionGrade,
    "question_source": questionSource,
    "tags": tags,
    "period": period,
    "is_changeable": isChangeable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAtValues.reverse[updatedAt],
    "expired_date": expiredDate,
    "hit_count": hitCount,
    "mistake_count": mistakeCount,
    "status": status,
  };
}

enum ExamName { AA }

final examNameValues = EnumValues({
  "aa": ExamName.AA
});

enum UpdatedAt { THE_00000000000000 }

final updatedAtValues = EnumValues({
  "0000-00-00 00:00:00": UpdatedAt.THE_00000000000000
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}*/
