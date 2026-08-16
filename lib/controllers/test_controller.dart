import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/live_model_test_model.dart';
import '../models/model_test_list_model.dart';
import '../models/single_model_test_model.dart';
import '../models/single_model_test_result_model.dart';
import '../services/remote_services.dart';

class TestController extends GetxController{
  var parentId="".obs;
  var endPoint="".obs;

  var isLoading=true.obs;
  var isUpdating=false.obs;
  var isLoadingMore=false.obs;
  var modelTestListData=ModelTestListModel().obs;
  var modelTestList=<SingleModelTestModel>[].obs;

  var liveResponseData=LiveModelTestModel().obs;
  var archiveDataList=<SingleModelTestResultModel>[].obs;
  var liveTestsList=<SingleModelTestResultModel>[].obs;




  void getModelTestListData()async{
    isLoading.value=true;
  //  var endPoint=AppStrings.getModelTestListEndPoint;
    var parameters={
      "id":parentId.value
    };
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint.value, parameters:parameters);
      if(data!=null){
        modelTestListData.value=ModelTestListModel.fromJson(data);
        modelTestList.value=modelTestListData.value.data?.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }


  void getPreviousJobTestListData()async{
    isLoading.value=true;
    //var endPoint=AppStrings.getPreviousYearQuestionsListEndPoint;
    var parameters={
      "id":parentId.value,
    };
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint.value, parameters: parameters);
      if(data!=null){
        modelTestListData.value=ModelTestListModel.fromJson(data);
        modelTestList.value=modelTestListData.value.data?.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }

  void getLiveTestListData()async{
   // isLoading.value=true;
    var endPoint=AppStrings.getLiveTestListEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        liveResponseData.value=LiveModelTestModel.fromJson(data);

        liveTestsList.value=liveResponseData.value.liveList??[];
        archiveDataList.value=liveResponseData.value.archiveList?.data??[];

      }
    } finally {
      isLoading.value=false;
      isUpdating.value=false;
    }
  }

  void loadMoreArchiveData() async {
    try {
      var data=await RemoteServices.getRequestLoadMore(liveResponseData.value.archiveList?.nextPageUrl??"", {});
      if(data!=null){
        liveResponseData.value=LiveModelTestModel.fromJson(data);
        archiveDataList.addAll(liveResponseData.value.archiveList?.data??[]);
      }
    } finally {
      isLoadingMore.value=false;
    }
  }


  void loadMoreModelTestData() async {
    try {
      var parameters={
        "id":parentId.value,
        "page":((modelTestListData.value.data?.currentPage??0)+1).toString()
      };
      var data=await RemoteServices.getRequest(endPoint:endPoint.value,parameters:parameters);
      if(data!=null){
        modelTestListData.value=ModelTestListModel.fromJson(data);
        modelTestList.addAll(modelTestListData.value.data?.data??[]);
      }
    } finally {
      isLoadingMore.value=false;
    }
  }

}

