class SingleQuestionModel {
  SingleQuestionModel({
    this.id,
    this.examName,
    this.subject,
    this.chapterGroup,
    this.chapter,
    this.question,
    this.hints,
    this.insertedFromIp,
    this.questionBy,
    this.display,
    this.isPrev,
    this.options,
    this.hasParagraph,
    this.questionGrade,
    this.questionSource,
    this.tags,
    this.period,
    this.isChangeable,
    this.createdAt,
    this.updatedAt,
    this.expiredDate,
    this.hitCount,
    this.mistakeCount,
    this.status,
    this.myOptions,
    this.correctAnswerIndex,
    this.formattedOptions,
    this.ans,
    this.correctAns,
    this.quizId,
    this.previousExams
  });

  int? id;
  String? examName;
  String? subject;
  String? chapterGroup;
  String? chapter;
  String? question;
  String? hints;
  String? insertedFromIp;
  int? questionBy;
  int? display;
  int? isPrev;
  String? options;
  int? hasParagraph;
  int? questionGrade;
  String? questionSource;
  String? tags;
  int? period;
  int? isChangeable;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic expiredDate;
  int? hitCount;
  int? mistakeCount;
  int? status;
  int? correctAnswerIndex;
  String? ans;
  String? correctAns;
  String? quizId;


  List<int>? myOptions;
  List<String>? formattedOptions;
  List<dynamic>? previousExams;

  factory SingleQuestionModel.fromJson(Map<String, dynamic> json) => SingleQuestionModel(
    id: json["id"] == null ? null : json["id"],
    examName: json["exam_name"] == null ? null : json["exam_name"],
    subject: json["subject"] == null ? null : json["subject"],
    chapterGroup: json["chapter_group"] == null ? null : json["chapter_group"],
    chapter: json["chapter"] == null ? null : json["chapter"],
    question: json["question"] == null ? null : json["question"],
    hints: json["hints"] == null ? null : json["hints"],
    insertedFromIp: json["inserted_from_ip"] == null ? null : json["inserted_from_ip"],
    questionBy: json["question_by"] == null ? null : json["question_by"],
    display: json["display"] == null ? null : json["display"],
    isPrev: json["is_prev"] == null ? null : json["is_prev"],
    options: json["options"] == null ? null : json["options"],
    hasParagraph: json["has_paragraph"] == null ? null : json["has_paragraph"],
    questionGrade: json["question_grade"] == null ? null : json["question_grade"],
    questionSource: json["question_source"] == null ? null :json["question_source"],
    tags: json["tags"] == null ? null :json["tags"],
    period: json["period"] == null ? null : json["period"],
    isChangeable: json["is_changeable"] == null ? null : json["is_changeable"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    expiredDate: json["expired_date"] == null ? null : DateTime.parse(json["expired_date"]),
    hitCount: json["hit_count"] == null ? null : json["hit_count"],
    mistakeCount: json["mistake_count"] == null ? null : json["mistake_count"],
    status: json["status"] == null ? null : json["status"],
    myOptions: json["myOptions"] == null ? [] : List<int>.from(json["myOptions"].map((x) => x)),
    formattedOptions: json["formattedOptions"] == null ? [] : List<String>.from(json["formattedOptions"].map((x) => x)),
    correctAnswerIndex: json["correctAnswerIndex"] == null ? null : json["correctAnswerIndex"],
    ans: json["ans"] == null ? null : json["ans"],
    correctAns: json["correct_ans"] == null ? null : json["correct_ans"],
    quizId: json["quiz_id"] == null ? null : json["quiz_id"],
    previousExams: json["previous_exams"] == null ? null : json["previous_exams"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,

    "exam_name": examName == null ? null : examName,
    "subject": subject == null ? null : subject,
    "chapter_group": chapterGroup == null ? null : chapterGroup,
    "chapter": chapter == null ? null : chapter,
    "question": question == null ? null : question,
    "hints": hints == null ? null : hints,
    "inserted_from_ip": insertedFromIp == null ? null : insertedFromIp,
    "question_by": questionBy == null ? null : questionBy,
    "display": display == null ? null : display,
    "is_prev": isPrev == null ? null : isPrev,
    "options": options == null ? null : options,
    "has_paragraph": hasParagraph == null ? null : hasParagraph,
    "question_grade": questionGrade == null ? null : questionGrade,
    "question_source": questionSource == null ? null : questionSource,
    "tags": tags == null ? null :tags,
    "period": period == null ? null : period,
    "is_changeable": isChangeable == null ? null : isChangeable,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "expired_date": expiredDate == null ? null : "${expiredDate?.year.toString().padLeft(4, '0')}-${expiredDate?.month.toString().padLeft(2, '0')}-${expiredDate?.day.toString().padLeft(2, '0')}",
    "hit_count": hitCount == null ? null : hitCount,
    "mistake_count": mistakeCount == null ? null : mistakeCount,
    "status": status == null ? null : status,
    "myOptions": myOptions == null ? [] : List<dynamic>.from(myOptions!.map((x) => x)),
    "formattedOptions": formattedOptions == null ? [] : List<dynamic>.from(formattedOptions!.map((x) => x)),
    "correctAnswerIndex": correctAnswerIndex == null ? null : correctAnswerIndex,
    "ans": ans == null ? null : ans,
    "correct_ans": correctAns == null ? null : correctAns,
    "quiz_id": quizId == null ? null : quizId,
    "previous_exams": previousExams == null ? null : previousExams,
  };
}