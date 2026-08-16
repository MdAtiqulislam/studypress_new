


import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/enrollment_list_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';

class EnrollmentListPageController extends GetxController{

  var isLoading=false.obs;
  var response=EnrollmentListModel().obs;
  var myEnrollments=UserEnrollmentDataModel2().obs;
  var assessmentStatus=false.obs;

  var userSelected=<int>[].obs;

  @override
  void onInit()async {

    assessmentStatus.value=await LocalServices.getAssessmentStatus()??false;
    myEnrollments.value=(await LocalServices.getEnrollmentItems())??UserEnrollmentDataModel2();
    //fetchEnrollmentData();
   if((myEnrollments.value.userEnrollment?.length??0)>=1) for (var element in myEnrollments.value.enrollmentCategoryList!) {userSelected.add(element.id!);}
   fetchData();

    super.onInit();
  }

  void fetchData()async{
    isLoading.value=true;
    AppStrings.httpErrorMSG.value="";
    var endPoint=AppStrings.enrollmentListEndPoint;
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        response.value=EnrollmentListModel.fromJson(data);
       // print(response.value.data!.categoryList!.length);
      }
    }finally{
      isLoading.value=false;
    }
  }

  void onSelectedItems( bool isSelected, int selectedId){
    if(userSelected.value.length < 2 && isSelected && !userSelected.contains(selectedId)){
      userSelected.value.add(selectedId);
      userSelected.refresh();
    }else if(!isSelected){
      userSelected.value.remove(selectedId);
      userSelected.refresh();
    }
    else{
      CustomSnackBar(
          msg: 'You can select maximum tow categories',
        isWarning: true
      ).showSnackBar();
    }

    //print(userSelected);
  }

  void saveData() async {
    isLoading.value=true;
    var endPoint=AppStrings.storeEnrollmentEndpoint;
    var body={
      for(int i=0;i<userSelected.length;i++)'category_ids[$i]':userSelected[i].toString() ,
    };
    //var body={"category_ids":json.encode(userSelected.value)};

    try{
      var data=await RemoteServices.postRequest(endPoint:endPoint, body:body);
      if(data!=null){
        fetchEnrollmentData();
        CustomSnackBar(
          isSuccess: true,
          msg: data["msg"]
        ).showSnackBar();

        isLoading.value=false;
        if (assessmentStatus.value) {
          Get.offAllNamed("/home_page");
        }else{
          Get.offAllNamed("/assessment_test_page");
        }
      }

    }finally{
      isLoading.value=false;

    }

  }

  void fetchEnrollmentData()async{
    isLoading.value=true;
    var endPoint=AppStrings.getUserEnrollmentEndpoint;
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        myEnrollments.value=UserEnrollmentDataModel2.fromJson(data);
       // userEnrollmentModel.value=response.value.userEnrollment!;
       await LocalServices.storeUserEnrollment(myEnrollments.value);
        //courseListModel.value=response.value.courseList!;
        isLoading.value=false;
      }

    }finally{
      isLoading.value=false;
    }
  }


}