import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/get_last_five_model_test_model.dart';
import '../models/update_user_model.dart';
import '../models/user_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../utilities/show_snack_bar.dart';
import 'drawer_controller.dart';
import 'home_page_data_controller.dart';

class UserProfileController extends GetxController{
  var isLoading=true.obs;
  var isUpdating=false.obs;
  var modelTestData=GetLastFiveModelTestModel().obs;
  var userData=UserModel().obs;
  var updateUserData=UpdateUserModel().obs;
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController studyLevelController=TextEditingController();
  TextEditingController instituteController=TextEditingController();
  TextEditingController classNameController=TextEditingController();
  TextEditingController departmentController=TextEditingController();
  TextEditingController sessionController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    studyLevelController.dispose();
    instituteController.dispose();
    classNameController.dispose();
    departmentController.dispose();
    sessionController.dispose();
    addressController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  void onInit() async{
    // TODO: implement onInit
   // getLocalData();
    userData.value=await LocalServices.getUser()??UserModel();
    nameController.text=userData.value.data?.name??"";
    phoneController.text=userData.value.data?.details?.phone??"";
    emailController.text=userData.value.data?.email??"";
    studyLevelController.text=userData.value.data?.details?.studyLevel??"";
    instituteController.text=userData.value.data?.details?.instituteName??"";
    classNameController.text=userData.value.data?.details?.className??"";
    departmentController.text=userData.value.data?.details?.deptGroup??"";
    sessionController.text=userData.value.data?.details?.session??"";
    addressController.text=userData.value.data?.details?.address??"";
    getModelTests();
    super.onInit();
  }

  void getModelTests() async{
    var endPoint=AppStrings.getLastFiveModelTestEndpoint;
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        modelTestData.value=GetLastFiveModelTestModel.fromJson(data);
      }
    } finally {
      // TODO
      isLoading.value=false;
    }
  }

  void getLocalData()async{
    userData.value=await LocalServices.getUser()??UserModel();
  }

  void updateProfile()async{
    isUpdating.value=true;
    var body={
      "name":nameController.text,
      "email":emailController.text,
      "details":{
        "photo":"",
        "phone":phoneController.text,
        "study_level":studyLevelController.text,
        "institute_name":instituteController.text,
        "class_name":classNameController.text,
        "dept_group":departmentController.text,
        "session":sessionController.text,
        "address":addressController.text
      }
    };
    var endPoint=AppStrings.updateUserProfileEndPoint;

    print(body);

    try {
      var data=await RemoteServices.postRequestWithJsonData(endPoint:endPoint, body:body);
      updateUserData.value=UpdateUserModel.fromJson(data);

      print(data.toString());


      userData.value.data=updateUserData.value.data!;
      LocalServices.storeUser(userData.value);
      await Future.delayed(const Duration(seconds: 1),);
      HomePageDataController homePageDataController=Get.put(HomePageDataController());
      homePageDataController.userData.value.data=updateUserData.value.data!;
      homePageDataController.userData.refresh();
      MyDrawerController myDrawerController=Get.put(MyDrawerController());
      myDrawerController.user.value.data=updateUserData.value.data!;
      myDrawerController.user.refresh();
      userData.refresh();
      print(userData.value.data?.details?.studyLevel);

      Get.back();
      CustomSnackBar(
        isSuccess: true,
        msg: updateUserData.value.msg??""
      ).showSnackBar();

    } finally {
      isUpdating.value=false;
    }
  }

  void updatePassword()async{
    isUpdating.value=true;
    var endPoint=AppStrings.updatePasswordEndPoint;
    var body={
      "password":oldPasswordController.text,
      "new_password":newPasswordController.text
    };
    try {
      var data=await RemoteServices.postRequest(endPoint:endPoint, body:body);
      if(data!=null){
        Get.back();
        CustomSnackBar(
          isSuccess: true,
          msg:data["msg"]
        ).showSnackBar();
      }else{
        CustomSnackBar(
            isSuccess: false,
            msg:AppStrings.httpErrorMSG.value
        ).showSnackBar();
      }
    } finally {
      isUpdating.value=false;
    }
  }
}