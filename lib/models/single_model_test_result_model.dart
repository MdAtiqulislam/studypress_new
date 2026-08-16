class SingleModelTestResultModel {
  SingleModelTestResultModel({
    this.quizSummeryId,
    this.id,
    this.userId,
    this.testId,
    this.quizId,
    this.quizDate,
    this.timeTaken,
    this.totalCorrect,
    this.totalWrong,
    this.expertReview,
    this.marksAchieved,
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
    this.memberPaid,
  });

  int? quizSummeryId;
  int? id;
  int? userId;
  int? testId;
  String? quizId;
  DateTime? quizDate;
  int? timeTaken;
  int? totalCorrect;
  int? totalWrong;
  dynamic expertReview;
  dynamic marksAchieved;
  int? category;
  int? type;
  int? qType;
  int? isFeatured;
  String? name;
  String? details;
  dynamic marksCarry;
  int? totalQues;
  int? time;
  int? display;
  int? isPaid;
  dynamic examTime;
  dynamic examYear;
  dynamic averageTime;
  dynamic averageMarks;
  int? totalAttempt;
  dynamic highestMarks;
  dynamic examId;
  int? memberPaid;

  factory SingleModelTestResultModel.fromJson(Map<String, dynamic> json) => SingleModelTestResultModel(
    quizSummeryId: json["quiz_summery_id"] == null ? null : json["quiz_summery_id"],
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    testId: json["test_id"] == null ? null : json["test_id"],
    quizId: json["quiz_id"] == null ? null : json["quiz_id"],
    quizDate: json["quiz_date"] == null ? null : DateTime.parse(json["quiz_date"]),
    timeTaken: json["time_taken"] == null ? null : json["time_taken"],
    totalCorrect: json["total_correct"] == null ? null : json["total_correct"],
    totalWrong: json["total_wrong"] == null ? null : json["total_wrong"],
    expertReview: json["expert_review"],
    marksAchieved: json["marks_achieved"] == null ? null : json["marks_achieved"].toDouble(),
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
    examTime: json["exam_time"],
    examYear: json["exam_year"],
    averageTime: json["average_time"] == null ? null : json["average_time"],
    averageMarks: json["average_marks"] == null ? null : json["average_marks"],
    totalAttempt: json["total_attempt"] == null ? null : json["total_attempt"],
    highestMarks: json["highest_marks"] == null ? null : json["highest_marks"],
    examId: json["exam_id"],
    memberPaid: json["member_paid"],
  );

  Map<String, dynamic> toJson() => {
    "quiz_summery_id": quizSummeryId == null ? null : quizSummeryId,
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "test_id": testId == null ? null : testId,
    "quiz_id": quizId == null ? null : quizId,
    "quiz_date": quizDate == null ? null : quizDate!.toIso8601String(),
    "time_taken": timeTaken == null ? null : timeTaken,
    "total_correct": totalCorrect == null ? null : totalCorrect,
    "total_wrong": totalWrong == null ? null : totalWrong,
    "expert_review": expertReview,
    "marks_achieved": marksAchieved == null ? null : marksAchieved,
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
    "exam_time": examTime,
    "exam_year": examYear,
    "average_time": averageTime == null ? null : averageTime,
    "average_marks": averageMarks == null ? null : averageMarks,
    "total_attempt": totalAttempt == null ? null : totalAttempt,
    "highest_marks": highestMarks == null ? null : highestMarks,
    "exam_id": examId,
    "member_paid": memberPaid,
  };
}