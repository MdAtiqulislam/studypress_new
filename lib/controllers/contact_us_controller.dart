import 'package:get/get.dart';

import '../constraints/app_strings.dart';
import '../models/contact_us_model.dart';
import '../services/remote_services.dart';


class ContactUsPageController extends GetxController{

  var isLoading=true.obs;
  var contactData=ContactUsModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getContactInfo();
    super.onInit();
  }

  void getContactInfo()async{
    var endPoint=AppStrings.getContactUsEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint);
      if(data!=null){
        contactData.value=ContactUsModel.fromJson(data);
      }
    } finally {
      isLoading.value=false;
    }

  }
}