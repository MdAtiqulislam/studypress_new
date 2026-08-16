import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constraints/body_text.dart';
import '../../constraints/dimensions.dart';
import '../../constraints/header_text.dart';


class ScoreTimeLine extends StatelessWidget {
  
  final int score;
  final emojis=["Very Poor 😞","Poor 😟","Need Improvement 🤨","Good 🙂", "Very Good 😊"];
  final colors=[Colors.red,Colors.orange,Colors.lime,Colors.lightGreen.shade300, Colors.green];
   ScoreTimeLine({
    required this.score,
    super.key});


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       /* CircularPercentIndicator(
          radius: 50,
          lineWidth: 30,
          progressColor: getColor(),
          backgroundColor:Colors.grey,
          circularStrokeCap: CircularStrokeCap.butt,
          percent:score/100,
          center: HeaderText(text: "$score%",color: Colors.white,),
          animation: true,

        ),*/

        CircularPercentIndicator(
          radius: 45.r,
          lineWidth: 25.r,
          progressColor: getColor(),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.butt,
          percent: score / 100,
          center: HeaderText(
            text: "$score%",
            color: getColor(),
            resizeable: false,
          ),
          animation: true,
        ),


         SizedBox(height: AppDimensions.sectionPaddingVer.h,),
        Card(
            color: getColor(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(getText(score),style: const TextStyle(color: Colors.white),),
            ),),
         SizedBox(height: 10.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppDimensions.widgetPaddingHor,vertical: AppDimensions.widgetPaddingVer),
          child: BodyText(text: "Note: This is AI generated score. Actual score may vary in accordance with questions difficulties."),
        ),
      ],
    );
  }

  String getText(int score) {

    if(score<=30) {
      return emojis[0];
    } else if(score>30 && score<=50) {
      return  emojis[1];
    }else if(score>50 && score<=60) {
      return  emojis[2];
    }else if(score>60 && score<=70) {
      return  emojis[3];
    }else if(score>70 && score<=100) {
      return  emojis[4];
    }
    else {
      return "";
    }
  }
  Color getColor() {
    return Color.lerp(Colors.red, Colors.green, score / 100)!;
  }

}
