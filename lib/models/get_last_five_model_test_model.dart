// To parse this JSON data, do
//
//     final getLastFiveModelTestModel = getLastFiveModelTestModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/single_model_test_result_model.dart';



GetLastFiveModelTestModel? getLastFiveModelTestModelFromJson(String str) => GetLastFiveModelTestModel.fromJson(json.decode(str));

String getLastFiveModelTestModelToJson(GetLastFiveModelTestModel? data) => json.encode(data!.toJson());

class GetLastFiveModelTestModel {
  GetLastFiveModelTestModel({
    this.success,
    this.msg,
    this.data,
  });

  bool? success;
  String? msg;
  List<SingleModelTestResultModel?>? data;

  factory GetLastFiveModelTestModel.fromJson(Map<String, dynamic> json) => GetLastFiveModelTestModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<SingleModelTestResultModel?>.from(json["data"]!.map((x) => SingleModelTestResultModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}


