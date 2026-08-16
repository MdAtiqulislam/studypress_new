import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/registration_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';

class RegistrationController extends GetxController{


  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final passwordController=TextEditingController();
  final reTypePasswordController=TextEditingController();

  var isLoading = false.obs;
  var endPoint = AppStrings.registrationEndPoint;

  var response=RegistrationModel().obs;


  @override
  void dispose(){
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    reTypePasswordController.dispose();
    super.dispose();
  }

  void fetchData() async{
    isLoading.value = true;
    AppStrings.httpErrorMSG.value="";
    String name=nameController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String password=passwordController.text;

    //var header={"Authorization":"Bearer $token"};
    var body={
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
    };
    try {
      var data = await RemoteServices.postRequest(endPoint:endPoint, body:body,);
      if (data != null) {
        response.value = RegistrationModel.fromJson(data);
        //AppStrings.httpResponseMSG.value = response.value.msg!;
        isLoading.value = false;
        await LocalServices.storeToken(response.value.accessToken??"");
        await LocalServices.storeUser(response.value.data!);
        //await LocalServices.storeUserEnrollment(response.value.userEnrollment!);
        fetchEnrollmentData();
        CustomSnackBar( msg:response.value.msg!,isSuccess: true).showSnackBar();
        openEnrollmentListScreen();
      }else{
        CustomSnackBar( msg:AppStrings.httpErrorMSG.value,isSuccess: false).showSnackBar();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void submitForm() {
    fetchData();
  }

  void openEnrollmentListScreen() {
    Get.offAllNamed("/enrollment_list_page");
  }

  void fetchEnrollmentData()async{
    isLoading.value=true;
    var endPoint=AppStrings.getUserEnrollmentEndpoint;
    try{
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      // print(data);
      if(data!=null){
        // myEnrollments.value=UserEnrollmentDataModel.fromJson(data);
        // userEnrollmentModel.value=response.value.userEnrollment!;
        LocalServices.storeUserEnrollment(UserEnrollmentDataModel2.fromJson(data));
        //courseListModel.value=response.value.courseList!;
        isLoading.value=false;
      }

    }finally{
      isLoading.value=false;
    }
  }

}