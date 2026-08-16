import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';
import 'app_button.dart';

class PricingCard extends StatelessWidget {
  const PricingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppDimensions.leftPadding),
      child: Center(
        child: Container(
        color: Colors.green,
          //height: 400,
          child: Swiper(
            itemCount: 2,
            itemBuilder: (buildContext,index){
              return  Container(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                   Positioned(
                      top: -50,
                      left: 0,
                      right: 0,
                      child:CircleAvatar(
                        backgroundColor: AppColors.appPrimaryColor,
                        minRadius: 50,
                        maxRadius: 50,
                        child:Row(
                          children: [
                            HeaderText(text: "৳ 500",size: 30,color: AppColors.appSecondaryColor,),
                            BodyText(text: "/6 month")

                          ],
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [

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
                        child: AppButton(
                          offset: const Offset(0, 5),
                          bgColor: AppColors.appSuccessColor,
                          onTap: () {
                            //onConfirm();
                          },
                          child: HeaderText(
                            text: "Confirm",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      )
    );
  }
}
