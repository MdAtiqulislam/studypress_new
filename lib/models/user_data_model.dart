
class UserDataModel {
  UserDataModel({
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
  int? isOnline;
  dynamic isActive;
  dynamic isLocked;
  dynamic memType;
  dynamic lastAccessed;
  dynamic userKey;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserDetails? details;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"] == null ? null : json["id"],
    userName: json["user_name"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    facebookId: json["facebook_id"],
    googleId: json["google_id"],
    globalPass: json["global_pass"],
    creationDate: json["creation_date"],
    updateDate: json["update_date"],
    lastLogin: json["last_login"],
    isOnline: json["is_online"] == null ? null : json["is_online"],
    isActive: json["is_active"],
    isLocked: json["is_locked"],
    memType: json["mem_type"],
    lastAccessed: json["last_accessed"],
    userKey: json["user_key"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    details: json["details"] == null ? null : UserDetails.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_name": userName,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "facebook_id": facebookId,
    "google_id": googleId,
    "global_pass": globalPass,
    "creation_date": creationDate,
    "update_date": updateDate,
    "last_login": lastLogin,
    "is_online": isOnline == null ? null : isOnline,
    "is_active": isActive,
    "is_locked": isLocked,
    "mem_type": memType,
    "last_accessed": lastAccessed,
    "user_key": userKey,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "details": details == null ? null : details?.toJson(),
  };
}

class UserDetails {
  UserDetails({
    this.id,
    this.userId,
    this.fullName,
    this.address,
    this.phone,
    this.photo,
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
  dynamic phone;
  dynamic photo;
  dynamic studyLevel;
  dynamic instituteName;
  dynamic className;
  dynamic deptGroup;
  dynamic session;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    address: json["address"],
    phone: json["phone"] == null ? null : json["phone"],
    photo: json["photo"],
    studyLevel: json["study_level"],
    instituteName: json["institute_name"],
    className: json["class_name"],
    deptGroup: json["dept_group"],
    session: json["session"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "full_name": fullName == null ? null : fullName,
    "address": address,
    "phone": phone == null ? null : phone,
    "photo": photo,
    "study_level": studyLevel,
    "institute_name": instituteName,
    "class_name": className,
    "dept_group": deptGroup,
    "session": session,
  };
}