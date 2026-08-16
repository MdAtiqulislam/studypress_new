
import 'dart:convert';

import 'package:studypress_new/models/user_vocabulary_info_model.dart';

VocabularyMistakeCountModel vocabularyMistakeCountModelFromJson(String str) => VocabularyMistakeCountModel.fromJson(json.decode(str));

String vocabularyMistakeCountModelToJson(VocabularyMistakeCountModel data) => json.encode(data.toJson());

class VocabularyMistakeCountModel {
  VocabularyMistakeCountModel({
    this.success,
    this.msg,
    this.mistakeCount,
    this.userVocabularyInfo,
  });

  bool? success;
  String? msg;
  int? mistakeCount;
  UserVocabularyInfoModel? userVocabularyInfo;

  factory VocabularyMistakeCountModel.fromJson(Map<String, dynamic> json) => VocabularyMistakeCountModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    mistakeCount: json["mistake_count"] == null ? null : json["mistake_count"],
    userVocabularyInfo: json["userVocabularyInfo"] == null ? null : UserVocabularyInfoModel.fromJson(json["userVocabularyInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "mistake_count": mistakeCount == null ? null : mistakeCount,
    "userVocabularyInfo": userVocabularyInfo == null ? null : userVocabularyInfo?.toJson(),
  };
}


