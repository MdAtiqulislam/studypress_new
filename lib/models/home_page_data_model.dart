import 'dart:convert';


HomePageDataModel? homePageDataModelFromJson(String str) => HomePageDataModel.fromJson(json.decode(str));

String homePageDataModelToJson(HomePageDataModel? data) => json.encode(data!.toJson());

class HomePageDataModel {
  HomePageDataModel({
    this.success,
    this.msg,
    //this.jobCircular,
    //this.studyHints,
    //this.importantFacts,
    //this.currentNews,
    this.whatHappenedToday,
    this.quoteOfTheDay,
  });

  bool? success;
  String? msg;
 // List<JobCircular?>? jobCircular;
  //List<ImportantFact?>? studyHints;
  //List<ImportantFact?>? importantFacts;
  //List<SingleQuestionModel?>? currentNews;
  //List<CurrentNew?>? currentNews;
  List<WhatHappenedToday?>? whatHappenedToday;
  QuoteOfTheDay? quoteOfTheDay;

  factory HomePageDataModel.fromJson(Map<String, dynamic> json) => HomePageDataModel(
    success: json["success"],
    msg: json["msg"],
  //  jobCircular: json["jobCircular"] == null ? [] : json["jobCircular"] == null ? [] : List<JobCircular?>.from(json["jobCircular"]!.map((x) => JobCircular.fromJson(x))),
   // studyHints: json["study_hints"] == null ? [] : json["study_hints"] == null ? [] : List<ImportantFact?>.from(json["study_hints"]!.map((x) => ImportantFact.fromJson(x))),
   // importantFacts: json["importantFacts"] == null ? [] : json["importantFacts"] == null ? [] : List<ImportantFact?>.from(json["importantFacts"]!.map((x) => ImportantFact.fromJson(x))),
   // currentNews: json["current_news"] == null ? [] : json["current_news"] == null ? [] : List<SingleQuestionModel?>.from(json["current_news"]!.map((x) => SingleQuestionModel.fromJson(x))),
    whatHappenedToday: json["what_happened_today"] == null ? [] : json["what_happened_today"] == null ? [] : List<WhatHappenedToday?>.from(json["what_happened_today"]!.map((x) => WhatHappenedToday.fromJson(x))),
    quoteOfTheDay: QuoteOfTheDay.fromJson(json["quote_of_the_day"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
  //  "jobCircular": jobCircular == null ? [] : jobCircular == null ? [] : List<dynamic>.from(jobCircular!.map((x) => x!.toJson())),
   // "study_hints": studyHints == null ? [] : studyHints == null ? [] : List<dynamic>.from(studyHints!.map((x) => x!.toJson())),
   // "importantFacts": importantFacts == null ? [] : importantFacts == null ? [] : List<dynamic>.from(importantFacts!.map((x) => x!.toJson())),
   // "current_news": currentNews == null ? [] : currentNews == null ? [] : List<SingleQuestionModel>.from(currentNews!.map((x) => x!.toJson())),
    "what_happened_today": whatHappenedToday == null ? [] : whatHappenedToday == null ? [] : List<dynamic>.from(whatHappenedToday!.map((x) => x!.toJson())),
    "quote_of_the_day": quoteOfTheDay,
  };
}

/*class CurrentNew {
  CurrentNew({
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
  QuestionSource? questionSource;
  QuestionSource? tags;
  int? period;
  int? isChangeable;
  String? createdAt;
  String? updatedAt;
  dynamic expiredDate;
  int? hitCount;
  int? mistakeCount;
  int? status;

  factory CurrentNew.fromJson(Map<String, dynamic> json) => CurrentNew(
    id: json["id"],
    examName: json["exam_name"],
    subject: json["subject"],
    chapterGroup: json["chapter_group"],
    chapter: json["chapter"],
    question: json["question"],
    hints: json["hints"],
    insertedFromIp: json["inserted_from_ip"],
    questionBy: json["question_by"],
    display: json["display"],
    isPrev: json["is_prev"],
    options: json["options"],
    hasParagraph: json["has_paragraph"],
    questionGrade: json["question_grade"],
    questionSource: json["question_source"],
    tags: json["tags"],
    period: json["period"],
    isChangeable: json["is_changeable"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    expiredDate: json["expired_date"],
    hitCount: json["hit_count"],
    mistakeCount: json["mistake_count"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_name": examName,
    "subject": subject,
    "chapter_group": chapterGroup,
    "chapter": chapter,
    "question": question,
    "hints": hints,
    "inserted_from_ip": insertedFromIp,
    "question_by": questionBy,
    "display": display,
    "is_prev": isPrev,
    "options": options,
    "has_paragraph": hasParagraph,
    "question_grade": questionGrade,
    "question_source": questionSource,
    "tags": tags,
    "period": period,
    "is_changeable": isChangeable,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "expired_date": expiredDate,
    "hit_count": hitCount,
    "mistake_count": mistakeCount,
    "status": status,
  };
}*/


class ImportantFact {
  ImportantFact({
    this.id,
    this.title,
    this.details,
    this.hintsDate,
    this.display,
  });

  int? id;
  String? title;
  String? details;
  DateTime? hintsDate;
  int? display;

  factory ImportantFact.fromJson(Map<String, dynamic> json) => ImportantFact(
    id: json["id"],
    title: json["title"],
    details: json["details"],
    hintsDate: DateTime.parse(json["hints_date"]),
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "details": details,
    "hints_date": hintsDate?.toIso8601String(),
    "display": display,
  };
}

class JobCircular {
  JobCircular({
    this.id,
    this.comInfo,
    this.jobCat,
    this.userId,
    this.title,
    this.postName,
    this.education,
    this.experience,
    this.genderRequirement,
    this.deadline,
    this.logoImg,
    this.vacancyNo,
    this.jobResponsibility,
    this.jobRequirements,
    this.jobNature,
    this.experienceRequirementDetails,
    this.aditionalJobRequirement,
    this.jobLocation,
    this.salaryRange,
    this.salaryNegotiable,
    this.otherBenefits,
    this.jobSource,
    this.age,
    this.publishDate,
    this.details,
    this.applyInstructions,
    this.createDate,
    this.isPublished,
    this.link,
    this.linkText,
    this.location,
    this.tags,
    this.isFeatured,
  });

  int? id;
  int? comInfo;
  int? jobCat;
  int? userId;
  String? title;
  String? postName;
  String? education;
  String? experience;
  String? genderRequirement;
  DateTime? deadline;
  String? logoImg;
  String? vacancyNo;
  String? jobResponsibility;
  String? jobRequirements;
  String? jobNature;
  String? experienceRequirementDetails;
  String? aditionalJobRequirement;
  String? jobLocation;
  String? salaryRange;
  int? salaryNegotiable;
  String? otherBenefits;
  String? jobSource;
  String? age;
  DateTime? publishDate;
  String? details;
  String? applyInstructions;
  DateTime? createDate;
  int? isPublished;
  String? link;
  String? linkText;
  String? location;
  String? tags;
  int? isFeatured;

  factory JobCircular.fromJson(Map<String, dynamic> json) => JobCircular(
    id: json["id"],
    comInfo: json["com_info"],
    jobCat: json["job_cat"],
    userId: json["user_id"],
    title: json["title"],
    postName: json["post_name"],
    education: json["education"],
    experience: json["experience"],
    genderRequirement: json["gender_requirement"],
    deadline: DateTime.parse(json["deadline"]),
    logoImg: json["logo_img"],
    vacancyNo: json["vacancy_no"],
    jobResponsibility: json["job_responsibility"],
    jobRequirements: json["job_requirements"],
    jobNature: json["job_nature"],
    experienceRequirementDetails: json["experience_requirement_details"],
    aditionalJobRequirement: json["aditional_job_requirement"],
    jobLocation: json["job_location"],
    salaryRange: json["salary_range"],
    salaryNegotiable: json["salary_negotiable"],
    otherBenefits: json["other_benefits"],
    jobSource: json["job_source"],
    age: json["age"],
    publishDate: DateTime.parse(json["publish_date"]),
    details: json["details"],
    applyInstructions: json["apply_instructions"],
    createDate: DateTime.parse(json["create_date"]),
    isPublished: json["is_published"],
    link: json["link"],
    linkText: json["link_text"],
    location: json["location"],
    tags: json["tags"],
    isFeatured: json["is_featured"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "com_info": comInfo,
    "job_cat": jobCat,
    "user_id": userId,
    "title": title,
    "post_name": postName,
    "education": education,
    "experience": experience,
    "gender_requirement": genderRequirement,
    "deadline": deadline?.toIso8601String(),
    "logo_img": logoImg,
    "vacancy_no": vacancyNo,
    "job_responsibility": jobResponsibility,
    "job_requirements": jobRequirements,
    "job_nature": jobNature,
    "experience_requirement_details": experienceRequirementDetails,
    "aditional_job_requirement": aditionalJobRequirement,
    "job_location": jobLocation,
    "salary_range": salaryRange,
    "salary_negotiable": salaryNegotiable,
    "other_benefits": otherBenefits,
    "job_source": jobSource,
    "age": age,
    "publish_date": publishDate,
    "details": details,
    "apply_instructions": applyInstructions,
    "create_date": createDate?.toIso8601String(),
    "is_published": isPublished,
    "link": link,
    "link_text": linkText,
    "location": location,
    "tags": tags,
    "is_featured": isFeatured,
  };
}



class QuoteOfTheDay {
  QuoteOfTheDay({
    this.id,
    this.details,
    this.author,
    this.attachmentId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? details;
  String? author;
  dynamic attachmentId;
  dynamic createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory QuoteOfTheDay.fromJson(Map<String, dynamic> json) => QuoteOfTheDay(
    id: json["id"],
    details: json["details"],
    author: json["author"],
    attachmentId: json["attachment_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated-by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details,
    "author": author,
    "attachment_id": attachmentId,
    "created_by": createdBy,
    "updated-by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class WhatHappenedToday {
  WhatHappenedToday({
    this.id,
    this.title,
    this.details,
    this.photo,
    this.happeningDate,
    this.display,
  });

  int? id;
  String? title;
  String? details;
  String? photo;
  DateTime? happeningDate;
  int? display;

  factory WhatHappenedToday.fromJson(Map<String, dynamic> json) => WhatHappenedToday(
    id: json["id"],
    title: json["title"],
    details: json["details"],
    photo: json["photo"],
    happeningDate: DateTime.parse(json["happening_date"]),
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "details": details,
    "photo": photo,
    "happening_date": happeningDate?.toIso8601String(),
    "display": display,
  };
}


