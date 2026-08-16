import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constraints/app_colors.dart';
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: Get.height,
      width: Get.width,
      color: Colors.white.withOpacity(.8),
      child: const Center(
        child: CircularProgressIndicator(
         // strokeWidth: 10,
                    backgroundColor: AppColors.appSecondaryColor,
                    color: AppColors.appPrimaryAccentColor
        ),
      ),
    );
  }
}
