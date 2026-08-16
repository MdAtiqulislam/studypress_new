// To parse this JSON data, do
//
//     final assessmentDataModel = assessmentDataModelFromJson(jsonString);

import 'dart:convert';

AssessmentDataModel assessmentDataModelFromJson(String str) => AssessmentDataModel.fromJson(json.decode(str));

String assessmentDataModelToJson(AssessmentDataModel data) => json.encode(data.toJson());

class AssessmentDataModel {
  AssessmentDataModel({
    this.success,
    this.msg,
    this.data,
    this.userLevel,
    this.userAssessmentCompleted,
  });

  bool? success;
  String? msg;
  List<Datum>? data;
  int? userLevel;
  bool? userAssessmentCompleted;

  factory AssessmentDataModel.fromJson(Map<String, dynamic> json) => AssessmentDataModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    userLevel: json["userLevel"],
    userAssessmentCompleted: json["userAssessmentCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "userLevel": userLevel,
    "userAssessmentCompleted": userAssessmentCompleted,
  };
}

class Datum {
  Datum({
    this.assessmentId,
    this.qid,
    this.id,
    this.categoryId,
    this.chapterId,
    this.questionId,
    this.questionWeight,
    this.questionAttempted,
    this.correctionAnswered,
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

  int? assessmentId;
  int? qid;
  int? id;
  int? categoryId;
  int? chapterId;
  int? questionId;
  int? questionWeight;
  dynamic questionAttempted;
  dynamic correctionAnswered;
  String? examName;
  String? subject;
  String? chapterGroup;
  String? chapter;
  String? question;
  String? hints;
  String? insertedFromIp;
  int? questionBy;
  int? display;
  int? isPrev;
  String? options;
  int? hasParagraph;
  int? questionGrade;
  String? questionSource;
  String? tags;
  int? period;
  int? isChangeable;
  String? createdAt;
  String? updatedAt;
  dynamic expiredDate;
  int? hitCount;
  int? mistakeCount;
  int? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    assessmentId: json["assessment_id"],
    qid: json["qid"],
    id: json["id"],
    categoryId: json["category_id"],
    chapterId: json["chapter_id"],
    questionId: json["question_id"],
    questionWeight: json["question_weight"],
    questionAttempted: json["question_attempted"],
    correctionAnswered: json["correction_answered"],
    examName: json["exam_name"],
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    expiredDate: json["expired_date"],
    hitCount: json["hit_count"],
    mistakeCount: json["mistake_count"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "qid": qid,
    "id": id,
    "category_id": categoryId,
    "chapter_id": chapterId,
    "question_id": questionId,
    "question_weight": questionWeight,
    "question_attempted": questionAttempted,
    "correction_answered": correctionAnswered,
    "exam_name": examName,
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "expired_date": expiredDate,
    "hit_count": hitCount,
    "mistake_count": mistakeCount,
    "status": status,
  };
}
