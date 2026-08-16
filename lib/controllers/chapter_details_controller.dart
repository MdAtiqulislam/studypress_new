import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/chapter_details_model.dart';
import '../services/remote_services.dart';


class ChapterDetailsController extends GetxController{
  var isLoading =true.obs;
  var id="".obs;
  var response=ChapterDetailsModel().obs;



  void fetchDetailsData({required String id})async{
    isLoading.value=true;
    var endPoint=AppStrings.getChapterDetailsEndPoint;
    var parameters={
      "id":id
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        response.value=ChapterDetailsModel.fromJson(data);
        isLoading.value=false;
      }

    }finally{
      isLoading.value=false;
    }
  }

}