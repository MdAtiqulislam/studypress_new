class UserVocabularyInfoModel {
  UserVocabularyInfoModel({
    this.id,
    this.userId,
    this.userLevel,
    this.point,
    this.levelUp,
  });

  int? id;
  int? userId;
  int? userLevel;
  int? point;
  int? levelUp;

  factory UserVocabularyInfoModel.fromJson(Map<String, dynamic> json) => UserVocabularyInfoModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userLevel: json["user_level"] == null ? null : json["user_level"],
    point: json["point"] == null ? null : json["point"],
    levelUp: json["level_up"] == null ? null : json["level_up"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "user_level": userLevel == null ? null : userLevel,
    "point": point == null ? null : point,
    "level_up": levelUp == null ? null : levelUp,
  };
}