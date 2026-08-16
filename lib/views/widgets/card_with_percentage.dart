import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constraints/body_text.dart';
import '../../constraints/header_text.dart';


class CardWithPercentage extends StatelessWidget {

  Color textColor =Colors.white;
  int value;
  String title;
  String text;

  CardWithPercentage({
    super.key,
    required this.value,
    required this.title,
    required this.text,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
          clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        //set border radius more than 50% of height and width to make circle
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            height: 80.h,
            color: Colors.grey.shade200,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(text: title,align: TextAlign.start,),
                  SizedBox(height: 5,),
                  BodyText(text: text,align: TextAlign.start,)
                ],
              ),
            ),
          ),),
          Container(
            decoration: BoxDecoration(
              color: getColor(value),
              boxShadow: [
                BoxShadow(
                  color: getColor(value).withOpacity(.5),
                  offset: Offset(-2,0),
                  blurRadius: 10
                )
              ]
            ),
            //color: getColor(value),
            width: 100.w,
            height: 80.h,
            child:Center(child: HeaderText(text:"$value%",color:textColor,size: 36,)),
          )
        ],
      ),
    );
  }

  Color getColor(int value) {
    Color bgColor = Colors.red;

    switch (value~/10) {
      case 0:
        bgColor = Color(0xffeb3434);

        break;
      case 1:
      // do something else
        bgColor = Color(0xffea5840);


        break;
      case 2:
      // do something else
        bgColor = Color(0xffd58433);

        break;
      case 3:
      // do something else
        bgColor = Color(0xffd2902e);

        break;
      case 4:
      // do something else

        bgColor = Color(0xffebb734);

        break;
      case 5:
      // do something else
        bgColor = Color(0xfff6c414);
        break;
      case 6:
      // do something else
        bgColor = Color(0xffb9b101);
        break;
      case 7:
      // do something else
        bgColor = Color(0xffa9ce25);
        break;

      case 8:
      // do something else
        bgColor = Color(0xff62b929);

        break;

      case 9:
      // do something else
        bgColor = Color(0xff02a606);

        break;
      case 10:
      // do something else
        bgColor = Color(0xff018804);

        break;
    }
    return bgColor;
  }
}
