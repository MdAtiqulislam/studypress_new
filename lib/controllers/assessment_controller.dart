import 'dart:async';
import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/assessment_data_model.dart';
import '../models/assessment_data_store_model.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';
import '../utilities/show_snack_bar.dart';


class AssessmentController extends GetxController {
  var isLoading = true.obs;
  var isUpdating = false.obs;
  var userModel=UserModel().obs;
  var assessmentData = AssessmentDataModel().obs;
  var assessmentStoreDataModel=AssessmentDataStoreModel().obs;
  var formattedQuestion = "".obs;
  var formattedOption = [].obs;
  var correctAnsIndex = (-1).obs;
  var optionsIndex = ["A", "B", "C", "D", "E"];
  var questionWeight=10.obs;
  var assessmentCount=0.obs;
  var isCorrect = false.obs;
  var time=0.obs;
  var stopCounting=false.obs;


  late Timer timer;

  @override
  void onClose() {
    // TODO: implement onClose
    timer.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }
  @override
  void onInit() async{
    // TODO: implement onInit
    
    getAssessmentData();
    userModel.value=await LocalServices.getUser()??UserModel();
    //startTimer();
    super.onInit();
  }

  void getAssessmentData() async {
    //isLoading.value = true;
    isCorrect.value=false;
    var endPoint = AppStrings.getAssessmentDataEndPoint;
    var parameters={
      "question_weight":questionWeight.value.toString()
    };
    try {
      var data = await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if (data != null) {
        if(!stopCounting.value)startTimer();
        assessmentData.value = AssessmentDataModel.fromJson(data);

        questionWeight.value=assessmentData.value.data?[0].questionWeight??0;

        print("userAssessmentCompleted:${assessmentData.value.userAssessmentCompleted}");
        print(data);
        print(questionWeight);

        if((assessmentData.value.userAssessmentCompleted??false)){
          userModel.value.userAssessmentCompleted=true;
          await LocalServices.storeUser(userModel.value);
          timer.cancel();
          Get.offAllNamed("/home_page");

        }
        else{
          formattedOption.value = FormatText.getFormattedOptions(
              unformattedOption: assessmentData.value.data?[0].options ?? "");
          formattedQuestion.value = FormatText.getFormattedQuestion(
              unformattedQuestion: assessmentData.value.data?[0].question ?? "");
          correctAnsIndex.value = FormatText.getCorrectAnswerIndex(
              unformattedOption: assessmentData.value.data?[0].options ?? "");
        }
      }
    } finally {
      isLoading.value = false;
      isUpdating.value=false;
    }
  }


  void submitAssessmentData()async{
    isUpdating.value=true;
    assessmentCount++;
/*    if(isCorrect.value){
      questionWeight.value++;
    }*/
    var endPoint=AppStrings.submitUserAssessmentDataEndPoint;
    var body={
      "assessment_id":(assessmentData.value.data?[0].assessmentId).toString(),
      "qid":(assessmentData.value.data?[0].qid).toString(),
      "is_correct":(isCorrect.value?1:0).toString(),
      "question_weight":(assessmentData.value.data?[0].questionWeight??0).toString(),
      "assessment_count":assessmentCount.value.toString(),
    };

    try {
      var data=await RemoteServices.postRequest(endPoint:endPoint, body:body);
      if(data!=null){
        assessmentStoreDataModel.value=AssessmentDataStoreModel.fromJson(data);
        print(assessmentStoreDataModel.value.assessmentComplete);
        questionWeight.value=assessmentStoreDataModel.value.questionWeight??0;

       if(!(assessmentStoreDataModel.value.assessmentComplete??true)) {
         getAssessmentData();
       } else{
        await LocalServices.storeAssessmentStatus(true);
        userModel.value.userAssessmentCompleted=true;
        await LocalServices.storeUser(userModel.value);
         Get.offAllNamed("home_page");
         CustomSnackBar(
           isSuccess: true,
           msg: "Thank you for completing assessment Test."
         ).showSnackBar();
       }
      }
    } finally {
     // isUpdating.value=false;
    }

  }
  void startTimer(){
    time.value=0;
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value=time.value+1;
      //print(time);
    });
  }
}
