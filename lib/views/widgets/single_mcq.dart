import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../constraints/app_colors.dart';
import '../../constraints/dimensions.dart';
import 'app_button.dart';

class SingleMcq extends StatelessWidget {
  List options;
  String question;
  int correctAnswerIndex;
  SingleMcq({Key? key,required this.options,required this.question,required this.correctAnswerIndex}) : super(key: key);

  var clickIndex=99999.obs;
  var isCorrect=true.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:AppDimensions.leftPadding,
      vertical: AppDimensions.widgetPaddingVer),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0,3),
                      blurRadius: 10

                    )
                  ]
                ),
                child://BodyText(text: question,color: Colors.white,)
               Html(data: question,
                style: {
                  "body":Style(
                    color: Colors.white
                  )
                })
              ,),

           SizedBox(height: AppDimensions.sectionPaddingVer,),
           ListView.builder(
             shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: options.length,
               itemBuilder: (itemBuilder,index){
             return Obx(() => AppButton(
               borderRadius: 0,
               bgColor:isCorrect.value?Colors.green:Colors.red,
               shadowOpacity: 0,
               offset: Offset(0,0),
               shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
               onTap: () {
                 clickIndex.value=index;
                 print(clickIndex.value==correctAnswerIndex);

                 isCorrect.value=(clickIndex.value==correctAnswerIndex);
               },
               child: Html(data: options[index]),

             ));
           })


           /* AppButton(
              bgColor: AppColors.appSecondaryColor,
              offset: Offset(0,3),
              shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
              callback: () {  },
              child: HeaderText(text: "(A). পাল আমলে",align: TextAlign.start,maxLine: 5,color: Colors.white,),

            ),
            SizedBox(height: 10,),
            AppButton(
              bgColor: Colors.white,
              offset: Offset(0,3),
              shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
              callback: () {  },
              child: HeaderText(text: "(B). সেন আমলে",align: TextAlign.start,maxLine: 5,),

            ),
            SizedBox(height: 10,),
            AppButton(
              bgColor: Colors.white,
              offset: Offset(0,3),
              shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
              callback: () {  },
              child: HeaderText(text: "(C). মুঘল আমলে",align: TextAlign.start,maxLine: 5,),

            ),
            SizedBox(height: 10,),
            AppButton(
              bgColor: Colors.white,
              offset: Offset(0,3),
              shadowColor: AppColors.appSecondaryColor.withOpacity(.5),
              callback: () {  },
              child: HeaderText(text: "(D). খিলজী আমলে",align: TextAlign.start,maxLine: 5,),

            ),*/

          ],
        ),
      ),
    );
  }
}
