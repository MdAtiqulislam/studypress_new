import 'package:get/get.dart';
import 'package:studypress_new/controllers/practise_chapter_controller.dart';

import '../constraints/app_strings.dart';
import '../models/caregory_list_model.dart';
import '../models/get_all_questions_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';

class MistakeAndReviewController extends GetxController{

  var isLoading=true.obs;
  var isMistake=false.obs;
  var isReview=false.obs;
  var isCurrentWorld=false.obs;
  var title=''.obs;
  var categoryList=CategoryListModel().obs;
  var response=GetAllQuestionsModel().obs;
  var enrollmentData=UserEnrollmentDataModel2().obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    enrollmentData.value=(await LocalServices.getEnrollmentItems())!;
    super.onInit();
  }


  void getReviewCategoryList() async{
    var endPoint=AppStrings.getReviewCategoryListEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        categoryList.value=CategoryListModel.fromJson(data);
      }
    } finally {
      isLoading.value=false;
    }
  }

  void getMistakeCategoryList() async{
    var endPoint=AppStrings.getMistakeCategoryListEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        categoryList.value=CategoryListModel.fromJson(data);
      }
    } finally {
      // TODO
      isLoading.value=false;
    }
  }


  void openPage({required int index}) {

    if(isMistake.value){
      if(isCurrentWorld.value){
        PractiseChapterController practiseChapterController=Get.put(PractiseChapterController());
         practiseChapterController.id.value=("315");
        practiseChapterController.isLoading.value=true;
        practiseChapterController.isReview.value=false;
        practiseChapterController.isMistake.value=true;
        practiseChapterController.isPractise.value=false;
        practiseChapterController.score.value=0;
        practiseChapterController.wrongAns.value=0;
        practiseChapterController.correctAns.value=0;
        practiseChapterController.myAnswers.value.length=0;
        practiseChapterController.isCurrentWorld.value=true;
        practiseChapterController.fetchPracticeCurrentAffairsMistakeListData();
        Get.toNamed("/practise_page",arguments: ["id","Mistake List- Current Affairs"]);
      }

     else{
        PractiseChapterController practiseChapterController=Get.put(PractiseChapterController());
        practiseChapterController.id.value=(categoryList.value.data?[index].id.toString() ?? "");
        practiseChapterController.isMistake.value=true;
        practiseChapterController.isPractise.value=false;
        practiseChapterController.score.value=0;
        practiseChapterController.wrongAns.value=0;
        practiseChapterController.correctAns.value=0;
        practiseChapterController.myAnswers.value.length=0;
        practiseChapterController.isLoading.value=true;
        practiseChapterController.fetchMistakeListData();
        Get.toNamed("/practise_page",arguments: ["id","Mistake List"]);
      }
    }



    if(isReview.value){
      if(isCurrentWorld.value){
        PractiseChapterController practiseChapterController=Get.put(PractiseChapterController());
        practiseChapterController.id.value=("315");
        practiseChapterController.isLoading.value=true;
        practiseChapterController.isReview.value=true;
        practiseChapterController.isMistake.value=false;
        practiseChapterController.isPractise.value=false;
        practiseChapterController.score.value=0;
        practiseChapterController.wrongAns.value=0;
        practiseChapterController.correctAns.value=0;
        practiseChapterController.myAnswers.value.length=0;
        practiseChapterController.isCurrentWorld.value=true;
        practiseChapterController.fetchPracticeCurrentAffairsReviewListData();
        Get.toNamed("/practise_page",arguments: ["id","Review List- Current Affairs"]);
      }else{
        PractiseChapterController practiseChapterController=Get.put(PractiseChapterController());
        practiseChapterController.id.value=(categoryList.value.data?[index].id.toString() ?? "");
        practiseChapterController.isLoading.value=true;
        practiseChapterController.isReview.value=true;
        practiseChapterController.isPractise.value=false;
        practiseChapterController.isMistake.value=false;
        practiseChapterController.score.value=0;
        practiseChapterController.wrongAns.value=0;
        practiseChapterController.correctAns.value=0;
        practiseChapterController.myAnswers.value.length=0;
        practiseChapterController.fetchPracticeReviewListData();
        Get.toNamed("/practise_page",arguments: ["id","Review List-${categoryList.value.data?[index].name}"]);
      }
    }
  }


}