class SingleModelTestModel {
  SingleModelTestModel({
    this.id,
    this.category,
    this.type,
    this.qType,
    this.isFeatured,
    this.name,
    this.details,
    this.marksCarry,
    this.totalQues,
    this.time,
    this.display,
    this.isPaid,
    this.examTime,
    this.examYear,
    this.averageTime,
    this.averageMarks,
    this.totalAttempt,
    this.highestMarks,
    this.examId,
    this.memberPaid
  });

  int? id;
  int? category;
  int? type;
  int? qType;
  int? isFeatured;
  String? name;
  String? details;
  int? marksCarry;
  int? totalQues;
  int? time;
  int? display;
  int? isPaid;
  DateTime? examTime;
  dynamic? examYear;
  int? averageTime;
  double? averageMarks;
  int? totalAttempt;
  int? highestMarks;
  dynamic? examId;
  int? memberPaid;

  factory SingleModelTestModel.fromJson(Map<String, dynamic> json) => SingleModelTestModel(
    id: json["id"] == null ? null : json["id"],
    category: json["category"] == null ? null : json["category"],
    type: json["type"] == null ? null : json["type"],
    qType: json["q_type"] == null ? null : json["q_type"],
    isFeatured: json["is_featured"] == null ? null : json["is_featured"],
    name: json["name"] == null ? null : json["name"],
    details: json["details"] == null ? null : json["details"],
    marksCarry: json["marks_carry"] == null ? null : json["marks_carry"],
    totalQues: json["total_ques"] == null ? null : json["total_ques"],
    time: json["time"] == null ? null : json["time"],
    display: json["display"] == null ? null : json["display"],
    isPaid: json["is_paid"] == null ? null : json["is_paid"],
    examTime: json["exam_time"] == null ? null : DateTime.parse(json["exam_time"]),
    examYear: json["exam_year"],
    averageTime: json["average_time"] == null ? null : json["average_time"],
    averageMarks: json["average_marks"] == null ? null : json["average_marks"].toDouble(),
    totalAttempt: json["total_attempt"] == null ? null : json["total_attempt"],
    highestMarks: json["highest_marks"] == null ? null : json["highest_marks"],
    examId: json["exam_id"],
    memberPaid: json["member_paid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category": category == null ? null : category,
    "type": type == null ? null : type,
    "q_type": qType == null ? null : qType,
    "is_featured": isFeatured == null ? null : isFeatured,
    "name": name == null ? null : name,
    "details": details == null ? null : details,
    "marks_carry": marksCarry == null ? null : marksCarry,
    "total_ques": totalQues == null ? null : totalQues,
    "time": time == null ? null : time,
    "display": display == null ? null : display,
    "is_paid": isPaid == null ? null : isPaid,
    "exam_time": examTime == null ? null : examTime!.toIso8601String(),
    "exam_year": examYear,
    "average_time": averageTime == null ? null : averageTime,
    "average_marks": averageMarks == null ? null : averageMarks,
    "total_attempt": totalAttempt == null ? null : totalAttempt,
    "highest_marks": highestMarks == null ? null : highestMarks,
    "exam_id": examId,
    "member_paid": memberPaid,
  };
}