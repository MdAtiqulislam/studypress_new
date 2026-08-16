// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:studypress_new/models/user_data_model.dart';



UpdateUserModel? updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel? data) => json.encode(data!.toJson());

class UpdateUserModel {
  UpdateUserModel({
    this.success,
    this.msg,
    this.data,
    this.userProfileImg,
  });

  bool? success;
  String? msg;
  UserDataModel? data;
  String? userProfileImg;

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
    success: json["success"],
    msg: json["msg"],
    data: UserDataModel.fromJson(json["data"]),
    userProfileImg: json["user_profile_img"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data!.toJson(),
    "user_profile_img": userProfileImg,
  };
}

/*class Data {
  Data({
    this.id,
    this.userName,
    this.name,
    this.email,
    this.facebookId,
    this.googleId,
    this.globalPass,
    this.creationDate,
    this.updateDate,
    this.lastLogin,
    this.lastLogout,
    this.startBrowsingAt,
    this.endBrowsingAt,
    this.isOnline,
    this.isActive,
    this.isLocked,
    this.memType,
    this.lastAccessed,
    this.userKey,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  int? id;
  dynamic userName;
  String? name;
  String? email;
  dynamic facebookId;
  dynamic googleId;
  dynamic globalPass;
  dynamic creationDate;
  dynamic updateDate;
  dynamic lastLogin;
  dynamic lastLogout;
  dynamic startBrowsingAt;
  dynamic endBrowsingAt;
  int? isOnline;
  dynamic isActive;
  dynamic isLocked;
  dynamic memType;
  dynamic lastAccessed;
  dynamic userKey;
  DateTime? createdAt;
  DateTime? updatedAt;
  Details? details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userName: json["user_name"],
    name: json["name"],
    email: json["email"],
    facebookId: json["facebook_id"],
    googleId: json["google_id"],
    globalPass: json["global_pass"],
    creationDate: json["creation_date"],
    updateDate: json["update_date"],
    lastLogin: json["last_login"],
    lastLogout: json["last_logout"],
    startBrowsingAt: json["start_browsing_at"],
    endBrowsingAt: json["end_browsing_at"],
    isOnline: json["is_online"],
    isActive: json["is_active"],
    isLocked: json["is_locked"],
    memType: json["mem_type"],
    lastAccessed: json["last_accessed"],
    userKey: json["user_key"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "name": name,
    "email": email,
    "facebook_id": facebookId,
    "google_id": googleId,
    "global_pass": globalPass,
    "creation_date": creationDate,
    "update_date": updateDate,
    "last_login": lastLogin,
    "last_logout": lastLogout,
    "start_browsing_at": startBrowsingAt,
    "end_browsing_at": endBrowsingAt,
    "is_online": isOnline,
    "is_active": isActive,
    "is_locked": isLocked,
    "mem_type": memType,
    "last_accessed": lastAccessed,
    "user_key": userKey,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "details": details!.toJson(),
  };
}

class Details {
  Details({
    this.id,
    this.userId,
    this.fullName,
    this.address,
    this.phone,
    this.photo,
    this.avatarId,
    this.studyLevel,
    this.instituteName,
    this.className,
    this.deptGroup,
    this.session,
  });

  int? id;
  int? userId;
  String? fullName;
  dynamic address;
  String? phone;
  dynamic photo;
  dynamic avatarId;
  dynamic studyLevel;
  dynamic instituteName;
  dynamic className;
  dynamic deptGroup;
  dynamic session;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    userId: json["user_id"],
    fullName: json["full_name"],
    address: json["address"],
    phone: json["phone"],
    photo: json["photo"],
    avatarId: json["avatar_id"],
    studyLevel: json["study_level"],
    instituteName: json["institute_name"],
    className: json["class_name"],
    deptGroup: json["dept_group"],
    session: json["session"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "full_name": fullName,
    "address": address,
    "phone": phone,
    "photo": photo,
    "avatar_id": avatarId,
    "study_level": studyLevel,
    "institute_name": instituteName,
    "class_name": className,
    "dept_group": deptGroup,
    "session": session,
  };
}*/
