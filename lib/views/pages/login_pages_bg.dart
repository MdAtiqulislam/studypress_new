import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constraints/app_colors.dart';

class LoginPagesBG extends StatelessWidget {
  const LoginPagesBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Hero(
            tag: "login_page_bg",
            child: Container(
              height: 100.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(220.r),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 150.h,
            width: 220.w,
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(.8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(220.r),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 200.h,
            width: 240.w,
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(.6),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(220.r),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 300.h,
            width: 280.w,
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(.4),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(220.r),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 400.h,
            width:320.w,
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(220.r),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 500.h,
            width:360.w,
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor.withOpacity(.1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(220.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
