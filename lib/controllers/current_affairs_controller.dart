import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/current_affairs_model.dart';
import '../models/single_question_model.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';

class CurrentAffairsController extends GetxController{
  var isLoading=false.obs;
  var response=CurrentAffairsModel().obs;
  //var questions = <SingleQuestionModel>[].obs;
  //var clickedQuestionsId=[].obs;
  var formattedQuestions = <SingleQuestionModel>[].obs;
  var optionsIndex=["A", "B", "C", "D", "E"];

  var isLoadingMore=false.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    super.onInit();
  }
  void fetchData() async{
    isLoading.value=true;
    var endPoint=AppStrings.currentAffairsEndPoint;
    var parameters={
      "memberShip":"1"
    };

    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        response.value=CurrentAffairsModel.fromJson(data);
        response.value.data?.data?.forEach((element) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        });
      }
    }finally{
      isLoading.value=false;
    }
  }

  void loadMoreData() async{
    isLoadingMore.value=true;
    //var url="http://learn.studypress.org/api/v1/ajax/get_current_affairs?page=133";
    var url=response.value.data?.nextPageUrl.toString();

    try{
      var data=await RemoteServices.getRequestLoadMore(url!, {});
      if(data!=null){
        response.value=CurrentAffairsModel.fromJson(data);
        response.value.data?.data?.forEach((element) {
          formattedQuestions.value.add(FormatText.getSingleFormattedQuestion(unFormattedQuestion: element));
        });

      }
    }finally{

      isLoadingMore.value=false;
    }

  }

}