import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/my_review_list_model.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';

class ReviewListController extends GetxController{


  var isUpdating=false.obs;
  var isLoading=true.obs;
  var reviewListModel=MyReviewListModel().obs;
  var myReviewList=[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    getReviewList();
    super.onInit();
  }

  void getReviewList()async{

    myReviewList.value=[];
    var endPoint=AppStrings.myReviewListEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        reviewListModel.value=MyReviewListModel.fromJson(data);
        reviewListModel.value.data?.forEach((element) {myReviewList.add(element.qid);});
      }
    } finally {
      isLoading.value=false;
    }

  }


  void addToReviewList({required String qid,required String chapterId}) async{
    isUpdating.value=true;
    var endPoint=AppStrings.addToReviewListEndPoint;
    var parameters={
      "qid":qid,
      "chapter_id":chapterId
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        Get.closeAllSnackbars();
        CustomSnackBar(
            isSuccess: true,
            msg: data["msg"]
        ).showSnackBar();
        myReviewList.add(int.parse(qid));
      }
    }finally{
      isUpdating.value=false;
    }

  }

  void removeFromReviewList({required String qid}) async{
    isUpdating.value=true;
    var endPoint=AppStrings.removeFromReviewListEndPoint;
    var parameters={
      "qid":qid
    };
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint,parameters: parameters);
      if(data!=null){
        Get.closeAllSnackbars();
        CustomSnackBar(
            isSuccess: true,
            msg: data["msg"]
        ).showSnackBar();
        myReviewList.remove(int.parse(qid));

      }
    }finally{
      isUpdating.value=false;
    }
  }


}