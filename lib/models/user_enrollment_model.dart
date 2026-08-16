
import 'dart:convert';

UserEnrollmentModel userEnrollmentModelFromJson(String str) => UserEnrollmentModel.fromJson(json.decode(str));

String userEnrollmentModelToJson(UserEnrollmentModel data) => json.encode(data.toJson());

class UserEnrollmentModel {
  UserEnrollmentModel({
    this.userEnrollment,
  });

  List<UserEnrollment>? userEnrollment;

  factory UserEnrollmentModel.fromJson(Map<String, dynamic> json) => UserEnrollmentModel(
    userEnrollment: json["userEnrollment"] == null ? null : List<UserEnrollment>.from(json["userEnrollment"].map((x) => UserEnrollment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userEnrollment": userEnrollment == null ? null : List<dynamic>.from(userEnrollment!.map((x) => x.toJson())),
  };
}

class UserEnrollment {
  UserEnrollment({
    this.id,
    this.userId,
    this.categoryId,
    this.subscriptionType,
    this.subscriptionMonth,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? categoryId;
  String? subscriptionType;
  int? subscriptionMonth;
  int? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserEnrollment.fromJson(Map<String, dynamic> json) => UserEnrollment(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    subscriptionType: json["subscription_type"] == null ? null : json["subscription_type"],
    subscriptionMonth: json["subscription_month"] == null ? null : json["subscription_month"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "category_id": categoryId == null ? null : categoryId,
    "subscription_type": subscriptionType == null ? null : subscriptionType,
    "subscription_month": subscriptionMonth == null ? null : subscriptionMonth,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
  };
}
