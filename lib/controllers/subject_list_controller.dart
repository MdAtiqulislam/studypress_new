import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/subject_list_model.dart';
import '../services/remote_services.dart';


class SubjectListController extends GetxController{
  var isLoading =true.obs;
  var id="".obs;
  var response=SubjectListDataModel().obs;


  void fetchSubjectListData({required String id})async{
    isLoading.value=true;
    var endPoint=AppStrings.getSubjectListEndPoint;
    var parameters={
      "id":id,
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        response.value=SubjectListDataModel.fromJson(data);
        isLoading.value=false;
      }

    }finally{
      isLoading.value=false;
    }
  }

}