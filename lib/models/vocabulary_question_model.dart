// To parse this JSON data, do
//
//     final vocabularyQuestionModel = vocabularyQuestionModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/user_vocabulary_info_model.dart';

VocabularyQuestionModel vocabularyQuestionModelFromJson(String str) => VocabularyQuestionModel.fromJson(json.decode(str));

String vocabularyQuestionModelToJson(VocabularyQuestionModel data) => json.encode(data.toJson());

class VocabularyQuestionModel {
  VocabularyQuestionModel({
    this.success,
    this.msg,
    this.list,
    this.userVocabularyInfo,
    this.mistakeCount
  });

  bool? success;
  String? msg;
  List<ListElement>? list;
  UserVocabularyInfoModel? userVocabularyInfo;
  int? mistakeCount;

  factory VocabularyQuestionModel.fromJson(Map<String, dynamic> json) => VocabularyQuestionModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    mistakeCount: json["mistake_count"] == null ? null : json["mistake_count"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    userVocabularyInfo: json["userVocabularyInfo"] == null ? null : UserVocabularyInfoModel.fromJson(json["userVocabularyInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "mistake_count": mistakeCount == null ? null : mistakeCount,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
    "userVocabularyInfo": userVocabularyInfo == null ? null : userVocabularyInfo?.toJson(),

  };
}

class ListElement {
  ListElement({
    this.vocabularyQuestionId,
    this.question,
    this.options,
    this.level,
    this.wordId,
    this.display,
    this.createdAt,
    this.updatedAt,
    this.word,
    this.formattedOptions
  });

  int? vocabularyQuestionId;
  String? question;
  String? options;
  String? formattedOptions;
  int? level;
  int? wordId;
  int? display;
  DateTime? createdAt;
  DateTime? updatedAt;
  Word? word;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    vocabularyQuestionId: json["vocabulary_question_id"] == null ? null : json["vocabulary_question_id"],
    question: json["question"] == null ? null : json["question"],
    options: json["options"] == null ? null : json["options"],
    formattedOptions: json["formatted_options"] == null ? null : json["formatted_options"],
    level: json["level"] == null ? null : json["level"],
    wordId: json["word_id"] == null ? null : json["word_id"],
    display: json["display"] == null ? null : json["display"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    word: json["word"] == null ? null : Word.fromJson(json["word"]),
  );

  Map<String, dynamic> toJson() => {
    "vocabulary_question_id": vocabularyQuestionId == null ? null : vocabularyQuestionId,
    "question": question == null ? null : question,
    "options": options == null ? null : options,
    "formatted_options": formattedOptions == null ? null : formattedOptions,
    "level": level == null ? null : level,
    "word_id": wordId == null ? null : wordId,
    "display": display == null ? null : display,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "word": word == null ? null : word?.toJson(),
  };
}

class Word {
  Word({
    this.id,
    this.word,
    this.meaning,
    this.synonyms,
    this.antonyms,
    this.example,
    this.display,
  });

  int? id;
  String? word;
  String? meaning;
  String? synonyms;
  String? antonyms;
  String? example;
  int? display;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json["id"] == null ? null : json["id"],
    word: json["word"] == null ? null : json["word"],
    meaning: json["meaning"] == null ? null : json["meaning"],
    synonyms: json["synonyms"] == null ? null : json["synonyms"],
    antonyms: json["antonyms"] == null ? null : json["antonyms"],
    example: json["example"] == null ? null : json["example"],
    display: json["display"] == null ? null : json["display"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "word": word == null ? null : word,
    "meaning": meaning == null ? null : meaning,
    "synonyms": synonyms == null ? null : synonyms,
    "antonyms": antonyms == null ? null : antonyms,
    "example": example == null ? null : example,
    "display": display == null ? null : display,
  };
}

