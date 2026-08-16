
import 'dart:convert';

import 'model_test_list_model.dart';



SubjectListDataModel subjectListDataModelFromJson(String str) => SubjectListDataModel.fromJson(json.decode(str));

String subjectListDataModelToJson(SubjectListDataModel data) => json.encode(data.toJson());

class SubjectListDataModel {
  SubjectListDataModel({
    this.success,
    this.msg,
    this.subjectItem,
    this.dataList,
  });

  bool? success;
  String? msg;
  SubjectItem? subjectItem;
  List<SubjectItem>? dataList;

  factory SubjectListDataModel.fromJson(Map<String, dynamic> json) => SubjectListDataModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    subjectItem: json["subjectItem"] == null ? null : SubjectItem.fromJson(json["subjectItem"]),
    dataList: json["dataList"] == null ? null : List<SubjectItem>.from(json["dataList"].map((x) => SubjectItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "subjectItem": subjectItem == null ? null : subjectItem?.toJson(),
    "dataList": dataList == null ? null : List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}


