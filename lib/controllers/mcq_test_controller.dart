import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/get_all_questions_model.dart';
import '../models/quiz_data_store_response_model.dart';
import '../models/quiz_model.dart';
import '../models/single_question_model.dart';
import '../models/store_answer_model.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';
import '../utilities/show_snack_bar.dart';
import 'mcq_report_controller.dart';

class MCQTestController extends GetxController {
  var isLoading = true.obs;
  var isUpdating = false.obs;
  var currentQuestionIndex = 0.obs;
  var currentAnswerIndex = (-1).obs;
  var responseModelTest = GetAllQuestionsModel().obs;
  var responseQuiz = QuizModel().obs;
  var questions = <SingleQuestionModel>[].obs;
  var clickedQuestionsId = [].obs;
  var formattedQuestions = <SingleQuestionModel>[].obs;
  var optionsIndex = ["A", "B", "C", "D", "E"];
  var timeSeconds = 0.obs;
  var userData = UserModel().obs;
  var userAnswerModel = StoreAnswerModel().obs;
  var storeDataResponse = QuizDataStoreResponseModel().obs;
  var chapterId = "".obs;
  var testId = "".obs;
  var endPoint=AppStrings.modelTestEndPoint.obs;

//  var chapterId = "".obs;
  var totalCorrectAns = 0;
  var totalWrongAns = 0;
  var startTime = DateTime.now().obs;
  var quizType = "chapterQuiz".obs; //chapterQuiz or modelTest

  var chapterQuiz = <ChapterQuiz>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    userData.value = await LocalServices.getUser() ?? UserModel();
    super.onInit();
  }

  void fetchTestData() async {
    isLoading.value = true;
    formattedQuestions.value = [];
    questions.value=[];
    clickedQuestionsId.value=[];
    chapterQuiz.value=[];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];

    // var endPoint=AppStrings.mcqTestEndPoint+id;
    var parameters={
      "id":testId.value
    };
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint.value,parameters: parameters);
      if (data != null) {
        responseModelTest.value = GetAllQuestionsModel.fromJson(data);
        questions.value = responseModelTest.value.data?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        if(timeSeconds.value==0)timeSeconds.value=(responseModelTest.value.data?.total??0)*30;
        startTime.value = DateTime.now();

      }
    } finally {
      // TODO
      isLoading.value = false;
      isUpdating.value=false;
    }
  }



  void fetchQuizData() async {
    isLoading.value = true;
    formattedQuestions.value = [];
    questions.value=[];
    clickedQuestionsId.value=[];
    chapterQuiz.value=[];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];

    // var endPoint=AppStrings.mcqTestEndPoint+id;
    var parameters={
      "chapter":chapterId.value
    };
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint.value,parameters: parameters);
      if (data != null) {
        responseQuiz.value = QuizModel.fromJson(data);
        questions.value = responseQuiz.value.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        if(timeSeconds.value==0)timeSeconds.value=(responseQuiz.value.data?.length??0)*30;
        startTime.value = DateTime.now();

      }
    } finally {
      // TODO
      isLoading.value = false;
      isUpdating.value=false;
    }
  }


  void fetchCurrentAffairsQuizData() async {
    isLoading.value = true;
    formattedQuestions.value = [];
    questions.value=[];
    clickedQuestionsId.value=[];
    chapterQuiz.value=[];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value = [];
    FormatText.formattedQuestion.value = [];
    FormatText.correctAnswerIndex.value = [];

     var endPoint=AppStrings.currentAffairsMCQTestEndPoint;
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint);
      if (data != null) {
        responseQuiz.value = QuizModel.fromJson(data);
        questions.value = responseQuiz.value.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }
        if(timeSeconds.value==0)timeSeconds.value=(responseQuiz.value.data?.length??0)*30;
        startTime.value = DateTime.now();

      }
    } finally {
      // TODO
      isLoading.value = false;
      isUpdating.value=false;
    }
  }




  void loadNextQuestion(
      {required int questionIndex, required int answerIndex}) {


    if (formattedQuestions.value[questionIndex].myOptions!.isNotEmpty &&
        !clickedQuestionsId.value.contains(questionIndex)) {
      clickedQuestionsId.value.add(questionIndex);
      RemoteServices.itemHitCount(
          qId: formattedQuestions.value[questionIndex].id.toString());
     /* if (formattedQuestions.value[questionIndex].correctAnswerIndex !=
          answerIndex) {
        RemoteServices.itemMistakeCount(
            qId: formattedQuestions.value[questionIndex].id.toString());
      }*/
    }
  }


  void submitData() async {
    isUpdating.value = true;
    totalCorrectAns = 0;
    totalWrongAns = 0;
    var timeTaken = DateTime.now().difference(startTime.value);
    for (var element in formattedQuestions) {
      if (element.ans != null) {
        if (element.ans == element.correctAns) {
          totalCorrectAns++;
        } else {
          totalWrongAns++;
        }
      }
      chapterQuiz.add(
        ChapterQuiz(
            qid: element.id, ans: element.ans, correctAns: element.correctAns),
      );
    }
    userAnswerModel.value.userId = userData.value.data?.id;
    userAnswerModel.value.chapterId = chapterId.value;
    userAnswerModel.value.timeTaken = timeTaken.inSeconds;
    userAnswerModel.value.totalCorrect = totalCorrectAns;
    userAnswerModel.value.totalWrong = totalWrongAns;
    userAnswerModel.value.chapterQuiz = chapterQuiz.value;
    // var body = userAnswerModel().toJson();

    var body = quizType.value == "chapterQuiz"
        ? userAnswerModel.toJson()
        : {
            "test_id": testId.value,
            "time_taken": timeTaken.inSeconds,
            "total_correct": totalCorrectAns,
            "total_wrong": totalWrongAns,
            "chapter_quiz":
                List<dynamic>.from(chapterQuiz.map((x) => x.toJson()))
          };
       var endPoint = quizType.value == "chapterQuiz"
        ? AppStrings.storeChapterQuizDataEndPoint
        : AppStrings.storeModelTestQuizDataEndPoint;



       print(body);
       print(endPoint);

    try {
      var data = await RemoteServices.postRequestWithJsonData(endPoint:endPoint, body:body);
      if (data != null) {
        storeDataResponse.value = QuizDataStoreResponseModel.fromJson(data);

        MCQReportController mcqReportController=Get.put(MCQReportController());
        if (quizType.value == "modelTest") {
          Get.offAndToNamed("/mcq_report_page");
          mcqReportController.isModelTest.value = true;
          mcqReportController.isQuiz.value = false;
          mcqReportController.quizId.value=storeDataResponse.value.data?.quizId ?? "";
          mcqReportController.endPoint.value= AppStrings.getModelTestResultDetailsByIdEndPoint;
          mcqReportController.fetchModelTestData();
        }
        if (quizType.value == "chapterQuiz") {
          Get.offAndToNamed("/mcq_report_page");
          mcqReportController.isModelTest.value = false;
          mcqReportController.isQuiz.value = true;
          mcqReportController.quizId.value=(storeDataResponse.value.data?.quizId ?? "").toString();
          mcqReportController.fetchQuizData();
        }

        CustomSnackBar(
          isSuccess: true,
          msg: storeDataResponse.value.msg ?? "",
        ).showSnackBar();
      }
    } finally {
      isUpdating.value = false;
    }
  }


  void loadMoreData({required int questionIndex, required int answerIndex}) async {
    try {

      var parameters=quizType.value=="chapterQuiz"?{
        "chapter":chapterId.value,
        "page":((responseModelTest.value.data?.currentPage??0)+1).toString()
      }:{
        "id":testId.value,
        "page":((responseModelTest.value.data?.currentPage??0)+1).toString()
      };

      var data=await RemoteServices.getRequest(endPoint: endPoint.value,parameters: parameters);


     // var data=await RemoteServices.getRequestLoadMore(response.value.data?.nextPageUrl??"", {});
      if(data!=null){
        responseModelTest.value=GetAllQuestionsModel.fromJson(data);
        questions.value=(responseModelTest.value.data?.data??[]);
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(
              unFormattedQuestion: element));
        }

        loadNextQuestion(questionIndex: questionIndex, answerIndex: answerIndex);
        currentQuestionIndex.value++;
        currentAnswerIndex.value = -1;



      }
    } finally {
      isUpdating.value=false;
    }
  }

}
