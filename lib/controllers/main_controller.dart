import 'package:get/get.dart';

import '../services/local_services.dart';


class MainController extends GetxController{

  var token="".obs;
  @override
  void onInit() async {
    token.value=await LocalServices.getToken()??"";
    print(token);

    super.onInit();
  }
}