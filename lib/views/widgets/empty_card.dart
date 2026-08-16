import 'package:flutter/material.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';

class EmptyCard extends StatelessWidget {

  String title;
   EmptyCard({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/empty_box.png",height: 200,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.sectionPaddingHor,vertical: AppDimensions.sectionPaddingVer),
          child: HeaderText(text: title,maxLine: 10,color: AppColors.appWarningColor,),
        )
      ],
    );
  }
}
