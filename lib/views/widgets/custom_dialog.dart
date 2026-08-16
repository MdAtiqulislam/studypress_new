
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import 'app_button.dart';

class CustomDialog extends StatelessWidget {

 final bool showHeaderImage;
 final String? image;
 final String? titleText;
 final String? headerText;
 final String? bodyText;
 final String? confirmText;
 final String? cancelText;
 final VoidCallback? onConfirm;
 final VoidCallback? onCancel;
 final double? imagePadding;
 final bool? showConfirmButton;
 final bool? showCancelButton;
 final Widget? content;



   const CustomDialog({
     super.key,
     required this.showHeaderImage,
     this.image,
     this.titleText,
     this.headerText,
     this.bodyText,
     this.confirmText,
     this.cancelText,
     this.imagePadding,
     this.onConfirm,
     this.onCancel,
     this.showCancelButton,
     this.showConfirmButton,
     this.content,
   });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding:  EdgeInsets.all(AppDimensions.sectionPaddingVer.r),
        child: SizedBox(
          //height: 300,
          width: 350.sp,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if(showHeaderImage)Positioned(
                top: -50,
                left: 0,
                right: 0,
                child:CircleAvatar(
                  backgroundColor: AppColors.appPrimaryColor,
                  minRadius: 50,
                  maxRadius: 50,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(imagePadding??10.r),
                      child: Image.asset(
                        image??"",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50,horizontal: AppDimensions.leftPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    if((titleText??"").isNotEmpty)HeaderText(
                      text: titleText??"",
                     // text: ,
                      size: 30,
                      color: AppColors.appErrorColor,
                    ),
                    if((titleText??"").isNotEmpty)SizedBox(
                      height: AppDimensions.contentPaddingVer,
                    ),
                    if((headerText??"").isNotEmpty)HeaderText(
                      text: headerText??"",
                      size: 20,
                      color: AppColors.appHeaderTextColor,
                      maxLine: 10,
                    ),
                    if((headerText??"").isNotEmpty)SizedBox(
                      height: AppDimensions.contentPaddingVer,
                    ),
                    if((bodyText??"").isNotEmpty)BodyText(
                        text: bodyText??""),
                    if((bodyText??"").isNotEmpty)SizedBox(
                      height:
                      AppDimensions.sectionPaddingVer *
                          1.5,
                    ),
                    content??Text(""),
                    SizedBox(height: AppDimensions.sectionPaddingVer.h,),
                  ],
                ),
              ),

              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal:
                      AppDimensions.leftPadding,
                      vertical:
                      AppDimensions.contentPaddingVer),
                  child: Row(
                    children: [
                      if(showConfirmButton??true)Expanded(
                        child: AppButton(
                          offset: const Offset(0, 5),
                          bgColor: AppColors.appSuccessColor,
                          onTap: () {
                           onConfirm!();
                          },
                          child: HeaderText(
                            text: confirmText??"Confirm",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimensions.widgetPaddingHor,
                      ),
                      if(showCancelButton??true)Expanded(
                        child: AppButton(
                          offset: const Offset(0, 5),
                          bgColor: AppColors.appErrorColor,
                          onTap: () {
                            onCancel!();
                          },
                          child: HeaderText(
                            text: cancelText??"Cancel",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
