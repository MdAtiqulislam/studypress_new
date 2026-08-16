
import 'dart:convert';

MyReviewListModel myReviewListModelFromJson(String str) => MyReviewListModel.fromJson(json.decode(str));

String myReviewListModelToJson(MyReviewListModel data) => json.encode(data.toJson());

class MyReviewListModel {
  MyReviewListModel({
    this.success,
    this.msg,
    this.data,
    this.chapterItem,
  });

  bool? success;
  String? msg;
  List<ReviewListData>? data;
  dynamic chapterItem;

  factory MyReviewListModel.fromJson(Map<String, dynamic> json) => MyReviewListModel(
    success: json["success"] == null ? null : json["success"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<ReviewListData>.from(json["data"].map((x) => ReviewListData.fromJson(x))),
    chapterItem: json["chapterItem"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "chapterItem": chapterItem,
  };
}

class ReviewListData {
  ReviewListData({
    this.id,
    this.userId,
    this.qid,
  });

  int? id;
  int? userId;
  int? qid;

  factory ReviewListData.fromJson(Map<String, dynamic> json) => ReviewListData(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    qid: json["qid"] == null ? null : json["qid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "qid": qid == null ? null : qid,
  };
}
