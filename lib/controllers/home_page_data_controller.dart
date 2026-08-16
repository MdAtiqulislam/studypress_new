import 'package:get/get.dart';


import '../constraints/app_strings.dart';
import '../models/dash_board_data_model.dart';
import '../models/user_enrollment_data_model_2.dart';
import '../models/user_model.dart';
import '../models/user_strength_and_weakness_model.dart';
import '../services/local_services.dart';
import '../services/remote_services.dart';

class HomePageDataController extends GetxController{

  var token="".obs;
  var userEnrollmentModel=UserEnrollmentDataModel2().obs;
  var userData=UserModel().obs;
  var userStrengthAndWeaknessData=UserStrengthAndWeaknessModel().obs;

  var enrolledGrades=<UserGrade>[].obs;

  //var homePageData=HomePageDataModel().obs;
  var dashBoardData=DashBoardDataModel().obs;
  var isLoadingStrengthData=true.obs;
  var isLoadingHomePageData=true.obs;
  var assessmentStatus=false.obs;
  var categoryPerformanceData=<CategoryPerformancesProgress>[].obs;

  @override
  void onInit() async{
   token.value = await LocalServices.getToken()??"";
   userEnrollmentModel.value=(await LocalServices.getEnrollmentItems())!;
   userData.value=await LocalServices.getUser()??UserModel();
   await Future.delayed(const Duration(seconds: 2),);
    fetchStrengthAndWeaknessData();
    //fetchHomePageData();
    fetchDashBoardData();
    super.onInit();
  }

  void fetchStrengthAndWeaknessData() async{
    var endPoint=AppStrings.getStrengthAndWeaknessEndPoint;
    var data=await RemoteServices.getRequest(endPoint:endPoint);
    if(data!=null){
      userStrengthAndWeaknessData.value=UserStrengthAndWeaknessModel.fromJson(data);


      isLoadingStrengthData.value=false;
    }
  }


/* void fetchHomePageData() async{
    var endPoint=AppStrings.getHomePageDataEndPoint;
    var data=await RemoteServices.getRequest(endPoint, {});
    if(data!=null){
      homePageData.value=HomePageDataModel.fromJson(data);
      isLoadingHomePageData.value=true;
    }

  }*/


 void fetchDashBoardData() async{
    var endPoint=AppStrings.getDashBoardDataEndPoint;
    try {
      var data=await RemoteServices.getRequest(endPoint:endPoint);
      if(data!=null){
        dashBoardData.value=DashBoardDataModel.fromJson(data);
        categoryPerformanceData.value=dashBoardData.value.categoryPerformancesProgress??[];

         enrolledGrades.value = (dashBoardData.value.userGrades ?? [])
            .where((grade) => grade.inEnrollment == true)
            .toList();



        isLoadingHomePageData.value=true;
      }
    } finally {
      // TODO
      isLoadingHomePageData.value=false;
    }
  }

}