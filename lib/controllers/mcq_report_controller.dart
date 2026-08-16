import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/get_all_questions_model.dart';
import '../models/model_test_result_details_model.dart';
import '../models/my_review_list_model.dart';
import '../models/relult_data_model.dart';
import '../models/single_question_model.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';
import '../utilities/show_snack_bar.dart';

class MCQReportController extends GetxController {
  var formattedQuestions = <SingleQuestionModel>[].obs;
  var optionsIndex = ["A", "B", "C", "D", "E"];
  var title="".obs;
  var quizId="".obs;
  var endPoint="".obs;

  var isQuiz=false.obs;
  var isModelTest=false.obs;

  var isLoading=true.obs;
  var isLoadingMore=false.obs;
  var response = GetAllQuestionsModel().obs;


  //var quizData = QuizDataModel().obs;
  //var quizData = ModelTestResultDetailsModel().obs;
  var testData = ModelTestResultDetailsModel().obs;


  var questions = <SingleQuestionModel>[].obs;
  var correctAnswer = 0.obs;
  var wrongAnswer = 0.obs;
  var noAnswer = 0.obs;
  var correctAnswerPercentage = 0.0.obs;
  var wrongAnswerPercentage = 0.0.obs;
  var noAnswerPercentage = 0.0.obs;
  var score = 0.0.obs;
  var myReviewList=[].obs;
  var reviewListModel=MyReviewListModel().obs;
  var isUpdating=false.obs;

  var chartData=<ChartData>[].obs;

  @override
  void onInit() {
    getReviewList();
    super.onInit();
  }

/*  int getCorrectAnswer() {
    correctAnswer.value = 0;
    for (var element in formattedQuestions.value) {
     if(element.myOptions!.isNotEmpty){
       if (element.correctAnswerIndex == element.myOptions!.last) {
         correctAnswer.value++;
       }
     }
    }
    return correctAnswer.value;
  }
  int getWrongAnswer() {
    wrongAnswer.value = 0;
    for (var element in formattedQuestions.value) {
     if(element.myOptions!.isNotEmpty){
       if (element.correctAnswerIndex != element.myOptions!.last) {
         wrongAnswer.value++;
       }
     }
    }
    return wrongAnswer.value;
  }
  int getNoAnswer() {
    noAnswer.value = 0;
    for (var element in formattedQuestions.value) {
      if(element.myOptions!.isEmpty){
        noAnswer.value++;
      }
    }
    return noAnswer.value;
  }
  void calculation(){
    correctAnswer.value=0;
    wrongAnswer.value=0;
    noAnswer.value=0;
    score.value=0;
    int index=0;
    chartData.value=[];
    chartData.add(ChartData(index, score.value));

    for (var element in formattedQuestions.value){
      index++;
      if((element.ans??"").isNotEmpty){
        if (element.correctAns == element.ans) {
          correctAnswer.value++;
        }else{
          wrongAnswer.value++;
        }
      }else{
        noAnswer.value++;
      }
      score.value=correctAnswer.value-(wrongAnswer.value*.25);
      chartData.add(ChartData(index, score.value));
    }
    correctAnswerPercentage.value=(correctAnswer.value/formattedQuestions.length)*100;
    wrongAnswerPercentage.value=(wrongAnswer.value/formattedQuestions.length)*100;
    noAnswerPercentage.value=(noAnswer.value/formattedQuestions.length)*100;
  }*/


 /* void getChartData({required double cScore}){
    void calculation(){
    var  chartScore=cScore;
      int index=0;
      chartData.value=[];
      chartData.add(ChartData(index, chartScore));

      for (var element in formattedQuestions.value){
        index++;
        if((element.ans??"").isNotEmpty){
          if (element.correctAns == element.ans) {
            correctAnswer.value++;
          }else{
            wrongAnswer.value++;
          }
        }else{
          noAnswer.value++;
        }
        score.value=correctAnswer.value-(wrongAnswer.value*.25);
        chartData.add(ChartData(index, score.value));
      }
      correctAnswerPercentage.value=(correctAnswer.value/formattedQuestions.length)*100;
      wrongAnswerPercentage.value=(wrongAnswer.value/formattedQuestions.length)*100;
      noAnswerPercentage.value=(noAnswer.value/formattedQuestions.length)*100;
    }
  }*/

  void getReviewList()async{
    myReviewList.value=[];
    var endPoint=AppStrings.myReviewListEndPoint;
    var data=await RemoteServices.getRequest(endPoint:endPoint);
    if(data!=null){
      reviewListModel.value=MyReviewListModel.fromJson(data);
      reviewListModel.value.data?.forEach((element) {myReviewList.add(element.qid);});
    }
  }
  void addToReviewList({required String qid,required String chapterId}) async{
    isUpdating.value=true;
    var endPoint=AppStrings.addToReviewListEndPoint;
    var parameters={
      "qid":qid,
      "chapter_id":chapterId
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        Get.closeAllSnackbars();
        CustomSnackBar(
            isSuccess: true,
            msg: data["msg"]
        ).showSnackBar();
        myReviewList.add(int.parse(qid));
        myReviewList.refresh();
      }
    }finally{
      isUpdating.value=false;
    }
  }
  void removeFromReviewList({required String qid}) async{
    isUpdating.value=true;
    var endPoint=AppStrings.removeFromReviewListEndPoint;
    var parameters={
      "qid":qid
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        Get.closeAllSnackbars();
        CustomSnackBar(
            isSuccess: true,
            msg: data["msg"]
        ).showSnackBar();
        myReviewList.remove(int.parse(qid));
      }
    }finally{
      isUpdating.value=false;
    }

  }




  void fetchQuizData(/*{required String endPoint}*/) async {
    isQuiz.value=true;
    isModelTest.value=false;
    Get.toNamed("/mcq_report_page");
    formattedQuestions.value = [];
    // formattedOptions.value = [];
    FormatText.formattedOptions_2.value=[];
    FormatText.formattedQuestion.value=[];
    FormatText.correctAnswerIndex.value=[];
    isLoading.value = true;
     var endPoint = AppStrings.getQuizDetailsByIdEndPoint;
    var parameters={
      "quiz_id":quizId.value
    };
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if (data != null) {
        //quizData.value = ModelTestResultDetailsModel.fromJson(data);
        testData.value = ModelTestResultDetailsModel.fromJson(data);
        //title.value=quizData.value.;
        questions.value = testData.value.modelQuesiton?.data ?? [];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        }

        correctAnswer.value=(testData.value.quizSummery?.totalCorrect??0);
        wrongAnswer.value=(testData.value.quizSummery?.totalWrong??0);
        noAnswer.value=(testData.value.modelQuesiton?.total??0)-(correctAnswer.value+wrongAnswer.value);


        correctAnswerPercentage.value=(correctAnswer.value/(testData.value.modelQuesiton?.total??0))*100;
        wrongAnswerPercentage.value=(wrongAnswer.value/(testData.value.modelQuesiton?.total??0))*100;
        noAnswerPercentage.value=(noAnswer.value/(testData.value.modelQuesiton?.total??0))*100;



        //  MCQReportController mcqReportController=Get.put(MCQReportController());
        formattedQuestions.value=formattedQuestions.value;
        isLoading.value = false;
        //calculation();
      }
    } finally {
      isLoading.value = false;
    }
  }


  void fetchModelTestData(/*{required String endPoint}*/) async {
    isQuiz.value=false;
    isModelTest.value=true;
    Get.toNamed("/mcq_report_page");
    formattedQuestions.value = [];
    FormatText.formattedOptions_2.value=[];
    FormatText.formattedQuestion.value=[];
    FormatText.correctAnswerIndex.value=[];
    isLoading.value = true;
    var parameters={
      "quiz_id":quizId.value
    };
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint.value,parameters: parameters);
      if (data != null) {
        testData.value = ModelTestResultDetailsModel.fromJson(data);
        title.value=testData.value.modelTest?.name??"";
        questions.value = testData.value.modelQuesiton?.data??[];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        }


        correctAnswer.value=(testData.value.quizSummery?.totalCorrect??0);
        wrongAnswer.value=(testData.value.quizSummery?.totalWrong??0);
        noAnswer.value=(testData.value.modelQuesiton?.total??0)-(correctAnswer.value+wrongAnswer.value);

        print("Correct Answer: $correctAnswer");
        print("Wrong Answer: $wrongAnswer");
        print("No Answer: $noAnswer");

        correctAnswerPercentage.value=(correctAnswer.value/(testData.value.modelQuesiton?.total??0))*100;
        wrongAnswerPercentage.value=(wrongAnswer.value/(testData.value.modelQuesiton?.total??0))*100;
        noAnswerPercentage.value=(noAnswer.value/(testData.value.modelQuesiton?.total??0))*100;

       // formattedQuestions.value=formattedQuestions.value;
        isLoading.value = false;
       // calculation();
      }
    } finally {
      isLoading.value = false;
    }
  }

void loadMoreModelTestData()async{
    var parameters={
      "quiz_id":quizId.value,
      "page":((testData.value.modelQuesiton?.currentPage??0)+1).toString()
    };
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint.value,parameters: parameters);
      if(data!=null){
        testData.value=ModelTestResultDetailsModel.fromJson(data);
        questions.value = testData.value.modelQuesiton?.data??[];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        }
      }
      formattedQuestions.refresh();
    } finally {
      // TODO
      isLoadingMore.value=false;
    }

}


void loadMoreQuizTestData()async{
    var endPoint=AppStrings.getQuizDetailsByIdEndPoint;
    var parameters={
      "quiz_id":quizId.value,
      "page":((testData.value.modelQuesiton?.currentPage??0)+1).toString()
    };
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(data!=null){
        testData.value=ModelTestResultDetailsModel.fromJson(data);
        questions.value = testData.value.modelQuesiton?.data??[];
        for (var element in questions.value) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        }
      }
      formattedQuestions.refresh();
    } finally {
      // TODO
      isLoadingMore.value=false;
    }

}


}


class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}