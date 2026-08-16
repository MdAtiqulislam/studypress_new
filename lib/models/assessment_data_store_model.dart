

import 'dart:convert';

AssessmentDataStoreModel? assessmentDataStoreModelFromJson(String str) => AssessmentDataStoreModel.fromJson(json.decode(str));

String assessmentDataStoreModelToJson(AssessmentDataStoreModel? data) => json.encode(data!.toJson());

class AssessmentDataStoreModel {
  AssessmentDataStoreModel({
    this.success,
    this.msg,
    this.questionWeight,
    this.assessmentComplete,
  });

  bool? success;
  String? msg;
  int? questionWeight;
  bool? assessmentComplete;

  factory AssessmentDataStoreModel.fromJson(Map<String, dynamic> json) => AssessmentDataStoreModel(
    success: json["success"],
    msg: json["msg"],
    questionWeight: json["question_weight"],
    assessmentComplete: json["userAssessmentCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "question_weight": questionWeight,
    "userAssessmentCompleted": assessmentComplete,
  };
}
