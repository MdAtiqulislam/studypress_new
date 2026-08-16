import 'package:get/get.dart';


import '../models/model_test_result_list_model.dart';
import '../models/quiz_result_list_model.dart';
import '../models/single_model_test_result_model.dart';
import '../services/remote_services.dart';

class ResultListController extends GetxController{
  var isLoading=true.obs;
  var isLoadingMore=false.obs;
  var id="".obs;
  var title="".obs;

  var endPoint="".obs;
  var testType="".obs; //model test or live test

  var quizListData=QuizResultListModel().obs;
  var quizList=<SingleResultDataModel>[].obs;
  var modelTestListData=ModelTestResultListModel().obs;
  var modelTestList=<SingleModelTestResultModel>[].obs;



//quiz section
  void getQuizResultList(/*{required String endPoint}*/)async{
    isLoading.value=true;
    //var endPoint=AppStrings.getModelTestListEndPoint+id;
    var parameters={
      "id":id.value
    };
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint.value,parameters: parameters);
      if(data!=null){
        quizListData.value=QuizResultListModel.fromJson(data);
        quizList.value=quizListData.value.data?.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }



//Model Test section
  void getModelTestResultList(/*{required String endPoint}*/)async{
    isLoading.value=true;
    //var endPoint=AppStrings.getModelTestListEndPoint+id;
    var parameters={
      "id":id.value
    };
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint.value,parameters: parameters);
      if(data!=null){
        modelTestListData.value=ModelTestResultListModel.fromJson(data);
        modelTestList.value=modelTestListData.value.data?.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }


  void loadMoreQuizData() async {
    try {
      var data=await RemoteServices.getRequestLoadMore(quizListData.value.data?.nextPageUrl??"", {});
      if(data!=null){
        quizListData.value=QuizResultListModel.fromJson(data);
        quizList.addAll(quizListData.value.data?.data??[]);
      }
    } finally {
      isLoadingMore.value=false;
    }
  }



  void loadMoreModelTestData() async {
    try {
      var data=await RemoteServices.getRequestLoadMore(modelTestListData.value.data?.nextPageUrl??"", {});
      if(data!=null){
        modelTestListData.value=ModelTestResultListModel.fromJson(data);
        modelTestList.addAll(modelTestListData.value.data?.data??[]);
      }
    } finally {
      isLoadingMore.value=false;
    }
  }
}