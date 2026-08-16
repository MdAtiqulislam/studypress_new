class SubjectItem {
  SubjectItem({
    this.id,
    this.name,
    this.groupId,
    this.parentId,
    this.serial,
    this.display,
    this.examSerial,
  });

  int? id;
  String? name;
  int? groupId;
  int? parentId;
  int? serial;
  int? display;
  int? examSerial;

  factory SubjectItem.fromJson(Map<String, dynamic> json) => SubjectItem(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    serial: json["serial"] == null ? null : json["serial"],
    display: json["display"] == null ? null : json["display"],
    examSerial: json["exam_serial"] == null ? null : json["exam_serial"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "group_id": groupId == null ? null : groupId,
    "parent_id": parentId == null ? null : parentId,
    "serial": serial == null ? null : serial,
    "display": display == null ? null : display,
    "exam_serial": examSerial == null ? null : examSerial,
  };
}