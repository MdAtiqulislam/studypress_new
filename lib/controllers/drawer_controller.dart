import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/course_list_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';

class MyDrawerController extends GetxController{
  var isLoading =true.obs;

  var userEnrollmentModel=UserEnrollmentDataModel2().obs;
  var courseListModel=CoursesListDataModel().obs;
 // var response=UserEnrollmentDataModel().obs;
  var user=UserModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchEnrollmentData();
    fetchUserData();
    super.onInit();
  }
  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
    fetchEnrollmentData();
    return super.onStart;
  }

  void fetchUserData()async{
    user.value=(await LocalServices.getUser()??UserModel());
  }

  void fetchEnrollmentData()async{
    try{
      userEnrollmentModel.value= await (LocalServices.getEnrollmentItems())??UserEnrollmentDataModel2();
    }finally{
      isLoading.value=false;
    }
  }

  void logout()async{
    LocalServices.deleteData();
    Get.offAllNamed("/login_email_page");
  }

  void deleteAccount()async{
    isLoading.value=true;
    var endPoint=AppStrings.deleteAccountEndpoint;

    //print(endPoint);
    try {
      var data= await RemoteServices.getRequest(endPoint: endPoint);

      if(data!=null){
        LocalServices.deleteData();
        Get.offAllNamed("/login_email_page");
      }
    } finally {
     isLoading.value=false;
    }
  }

}