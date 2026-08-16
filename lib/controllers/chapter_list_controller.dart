import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/chapter_list_model.dart';
import '../services/remote_services.dart';

class ChapterListController extends GetxController{
  var isLoading =true.obs;
  var id="".obs;
  var response=ChapterListDataModel().obs;


  void fetchChapterListData({required String id})async{
    isLoading.value=true;
    var endPoint=AppStrings.getChapterListEndPoint;
    var parameters={
      "id":id
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);

      if(data!=null){
        response.value=ChapterListDataModel.fromJson(data);
        isLoading.value=false;
      }

    }finally{
      isLoading.value=false;
    }
  }

}