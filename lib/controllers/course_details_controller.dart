import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/course_details_model.dart';
import '../services/remote_services.dart';

class CourseDetailsController extends GetxController{
  var isLoading=true.obs;
  var isLoadingMore=false.obs;
  var response=CourseDetailsModel().obs;
  var courseDetailsData=<CourseDetailsData>[].obs;
  var id="".obs;

  void getCourseDetailsData(/*{required int id}*/)async{
    var endPoint=AppStrings.getCourseDetailsEndPoint;
    var parameters={
      "id":id.value
    };

    try {
      var data= await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);

      if(data!=null){
        response.value=CourseDetailsModel.fromJson(data);
        courseDetailsData.value=response.value.data?.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }

  void loadMoreData()async{
    var parameters={
      "id":id.value,
      "page":((response.value.data?.currentPage??0)+1).toString()
    };
    var endPoint=AppStrings.getCourseDetailsEndPoint;
    try{
      var data=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      response.value=CourseDetailsModel.fromJson(data);
      courseDetailsData.addAll(response.value.data?.data??[]);
    }finally{
      isLoadingMore.value=false;
    }
  }
}