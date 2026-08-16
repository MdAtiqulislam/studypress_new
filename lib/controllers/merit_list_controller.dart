import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/merit_list_data_model.dart';
import '../services/remote_services.dart';

class MeritListController extends GetxController{
  var isLoading=true.obs;
  var isLoadingMore=false.obs;
  var response=MeritListDataModel().obs;
  var meritListData=<MeritListData>[].obs;
  var qId="".obs;


  void fetchData(/*{required String qId}*/)async{
    var endPoint=AppStrings.getMeritListEndPoint;
    var parameters={
      "quiz_id":qId.value,
    };
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        response.value=MeritListDataModel.fromJson(data);
        meritListData.value=response.value.data?.data??[];

      }
    } finally {
      isLoading.value=false;
    }
  }

  void loadMoreData()async{
    var parameters={
      "quiz_id":qId.value,
      "page":((response.value.data?.currentPage??0)+1).toString(),
    };
    var endPoint=AppStrings.getMeritListEndPoint;

    try{
      var data=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(data!=null){
        response.value=MeritListDataModel.fromJson(data);
        meritListData.addAll(response.value.data?.data??[]);
      }

    }finally{
      isLoadingMore.value=false;
    }
  }
}