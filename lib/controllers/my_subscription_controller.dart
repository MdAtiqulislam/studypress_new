import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constraints/app_colors.dart';
import '../constraints/app_strings.dart';
import '../constraints/body_text.dart';
import '../constraints/dimensions.dart';
import '../constraints/header_text.dart';
import '../models/get_order_id_model.dart';
import '../models/membership_plan_model.dart';
import '../models/subscription_details_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';
import '../views/widgets/custom_dialog.dart';

class MySubscriptionController extends GetxController{

 // var myEnrollmentData=UserEnrollmentDataModel2().obs;
  var myEnrollmentData=MemberShipPlanModel().obs;
  var isLoading=false.obs;
  var isUpdating=false.obs;
  var orderIdModel=GetOrderIdModel().obs;
  var subscriptionDetails=SubscriptionDetailsModel().obs;
  var priceList = <String, List<PriceList>>{}.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
  //  myEnrollmentData.value=await LocalServices.getEnrollmentItems()??UserEnrollmentDataModel2();
    getMembershipData();
    super.onInit();
  }

  void getMembershipData()async{
    var endPoint=AppStrings.getMembershipPlanEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        myEnrollmentData.value=MemberShipPlanModel.fromJson(data);
        priceList.value=myEnrollmentData.value.categoryPriceList??{};
      }
    } finally {
      // TODO
    }
  }

  void quickPayment({int? id}) async{
    var endPoint=AppStrings.getOrderIdEndPoint;
    var body={"category_price_ids":[id]};

    var data=await RemoteServices.postRequestWithJsonData(endPoint: endPoint,body: body);
    if(data!=null){
      orderIdModel.value=GetOrderIdModel.fromJson(data);
      completePayment((orderIdModel.value.order?.id??0).toString());
    }

  }

  void completePayment(String orderId)async {
    var endPoint=AppStrings.makePaymentEndPoint;
    var body={
      "order_id":orderId
    };
    try {
      var data=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(data!=null){
        Get.toNamed("/ssl_commerz_page",arguments: [(data)["data"],
          orderIdModel.value.order?.amount??0]);
      }
    } finally {
      isUpdating.value=false;
    }
  }

  void getSubscriptionDetails({required var orderId})async{
    var endPoint=AppStrings.subscriptionDetailsEndPoint;
    var parameters={
      "id":orderId.toString()
    };
    try {
      var data=await RemoteServices.getRequest(endPoint: endPoint,parameters: parameters);
      if(data!=null){
        subscriptionDetails.value=SubscriptionDetailsModel.fromJson(data);
        Get.offAllNamed("/home_page");
        showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return CustomDialog(
                  showConfirmButton: false,
                  cancelText: "back",
                  showHeaderImage: true,
                  image: "assets/icons/checked.png",
                  headerText: "Subscription Details",
                  content: subscriptionDetailsContentSection(),
                  onCancel: () {
                    Get.back();
                  });
            });



      }
    } finally {
      isUpdating.value=false;
    }

  }

  Widget subscriptionDetailsContentSection() {
    return Container(
        margin: EdgeInsets.all(20.r),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subscriptionDetails.value.data?.details?.length??0,
                itemBuilder: (buildContext,index){
                  return Column(
                    children: [
                      HeaderText(text: "Course: ${subscriptionDetails.value.data?.details?[index].category?.name??""}",size: 14,),
                      Container(color: AppColors.appPrimaryColor,height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyText(text: "Duration:"),
                          BodyText(text: "${subscriptionDetails.value.data?.details?[index].categoryPrice?.duration??""} Month"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyText(text: "Price:"),
                          BodyText(text: "${subscriptionDetails.value.data?.details?[index].categoryPrice?.price??""} Taka"),
                        ],
                      ),
                     // HeaderText(text: "Price: ${subscriptionDetails.value.data?.details?[index].categoryPrice?.price??""} Taka"),
                      Container(color: AppColors.appPrimaryColor,height: 2,),
                      SizedBox(height: AppDimensions.widgetPaddingVer,)
                    ],

                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderText(text: "Total:",size: 14,),
                HeaderText(text: "${subscriptionDetails.value.data?.amount} Taka",size: 14,),
              ],
            ),
            SizedBox(height: AppDimensions.widgetPaddingVer,)
          ],
        )
    );
  }
}