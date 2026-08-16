import 'package:get/get.dart';
import '../constraints/app_strings.dart';
import '../models/user_model.dart';
import '../models/user_vocabulary_info_model.dart';
import '../models/vocabulary_mistake_count_model.dart';
import '../models/vocabulary_question_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/formate_text.dart';

class VocabularyAppController extends GetxController{

  var isLoading=true.obs;
  var isUpdating=false.obs;
  var vocabularyMistakeCountData=VocabularyMistakeCountModel().obs;
  var userInfo=UserModel().obs;
  var vocabularyQueData=VocabularyQuestionModel().obs;
  var vocabularyUserInfo=UserVocabularyInfoModel().obs;
  var  optionIndexes=["A","B","C","D","E"];
  var formattedOption=[].obs;
  var correctAnswerIndex=0.obs;
  var myAnswerIndex=(-1).obs;
  var isClicked=false.obs;
  var isDetailed=false.obs;
  var isRefine=false.obs;


  @override
  void onInit()async{
    fetchMistakeData();
    userInfo.value=(await LocalServices.getUser())!;
    super.onInit();
  }

  void fetchMistakeData()async{
    var endPoint=AppStrings.vocabularyMistakeCountEndPoint;
    var data=await RemoteServices.getRequest(endPoint:endPoint);
    if(data!=null){
      vocabularyMistakeCountData.value=VocabularyMistakeCountModel.fromJson(data);
      vocabularyUserInfo.value=vocabularyMistakeCountData.value.userVocabularyInfo??UserVocabularyInfoModel();
      isLoading.value=false;
      //isUpdating.value=false;
    }
  }

  void fetchQuestion({required String level}) async{
     myAnswerIndex.value=(-1);
     isClicked.value=false;
     isDetailed.value=false;
    isUpdating.value=true;
    var endPoint=!isRefine.value?AppStrings.getVocabularyQuestionEndPoint
        :AppStrings.getRefineVocabularyQuestionEndPoint;
    var parameters={
      "userLevel":level
    };
    var data= !isRefine.value? await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters)
        :await RemoteServices.getRequest(endPoint:endPoint);
    if(data!=null){
      vocabularyQueData.value=VocabularyQuestionModel.fromJson(data);
      vocabularyUserInfo.value=vocabularyQueData.value.userVocabularyInfo??UserVocabularyInfoModel();
      formattedOption.value=FormatText.getFormattedOptions(unformattedOption: vocabularyQueData.value.list?[0].options??"");
      correctAnswerIndex.value=FormatText.getCorrectAnswerIndex(unformattedOption:  vocabularyQueData.value.list?[0].options??"");
      isUpdating.value=false;
    }
  }

  void storeAnswer({required String id,required String type})async{
   // isUpdating.value=true;
    var endPoint=isRefine.value?AppStrings.storeRefineVocabularyAnswerEndPoint:AppStrings.storeVocabularyAnswerEndpoint;
    var body={"word_id":id,"type":type};
    var data=await RemoteServices.postRequest(endPoint:endPoint, body:body);
    if(data!=null){
      fetchMistakeData();
     // fetchQuestion(level: vocabularyUserInfo.value.userLevel.toString());
    }

  }

}