import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';

class BasicGridItem extends StatelessWidget {
  int index;
  Icon? icon;
  String title;
  String? subTitle;
  String image;
  VoidCallback? callback;
  Color? splashColor;
  Color bgColor;
  Color? gradientColor1;
  Color? gradientColor2;
  Color? titleTextColor;
  Color? subTitleTextColor;
  bool isGradientColour;
  double imageSize;
  double gapBetween;
  double? titleTextSize;
  double? subTitleSize;
  double? height;
  double? borderRadius;
  FontWeight titleFontWight;
  FontWeight subTitleFontWight;
  Widget? bottomContent;
  bool resizeable ;

  BasicGridItem(
      {
        super.key,
        this.height,
      required this.index,
      required this.title,
      this.icon,
      this.subTitle,
      required this.image,
      this.callback,
      this.splashColor,
      this.isGradientColour = true,
      this.imageSize = 50,
      this.gapBetween = 0,
      this.titleTextSize,
      this.subTitleSize,
      this.bgColor=Colors.grey,
      this.gradientColor1,
      this.gradientColor2,
      this.subTitleTextColor,
        this.titleTextColor,
        this.titleFontWight=FontWeight.bold,
        this.subTitleFontWight=FontWeight.normal,
        this.borderRadius,
        this.bottomContent,
        this.resizeable=false,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: isGradientColour
          ? BoxDecoration(
              //color: Color(0xff6750A4+(index*999887)),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius??10.r)),
              gradient: LinearGradient(colors: [
                gradientColor1??Color(0x356750A4 + (index * 199887)),
                gradientColor2??Color(0xff6750A4 + (index * 199887)),
              ]))
          : BoxDecoration(
              //color: bgColor??Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: isGradientColour?Colors.transparent:bgColor,
        child: InkWell(
          onTap: callback,
          splashColor: splashColor ?? AppColors.appSecondaryColor,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.r),
                  //  color: Colors.grey,
                  child: icon ??
                      Image.asset(
                        image,
                        width: imageSize,
                        //fit: BoxFit.fill,
                      ),
                ),
                SizedBox(
                  width: gapBetween,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: AppDimensions.contentPaddingHor),
                        child: HeaderText(
                          text: title,
                          align: TextAlign.start,
                          color: titleTextColor??Colors.white,
                          fontWeight: titleFontWight,
                          maxLine: 2,
                          size: titleTextSize ?? 14,
                          resizeable: resizeable,
                        ),
                      ),
                      if (subTitle != null)
                        Padding(
                          padding:  EdgeInsets.only(right: AppDimensions.contentPaddingHor),
                          child: BodyText(
                            text: subTitle!,
                            color: subTitleTextColor??Colors.white,
                            fontWeight: subTitleFontWight,
                            align: TextAlign.start,
                            size: subTitleSize ?? 12,
                            resizeable: false,
                          ),
                        ),
                      if(bottomContent!=null)bottomContent!
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
