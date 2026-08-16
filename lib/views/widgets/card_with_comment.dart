import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constraints/body_text.dart';
import '../../constraints/header_text.dart';

class CardWithComment extends StatelessWidget {

  Color textColor =Colors.white;

  String title;
  String text;

  CardWithComment({
    Key? key,
    required this.title,
    required this.text,

  }) : super(key: key);

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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/banner.jpg",),fit: BoxFit.fill),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(text: title,align: TextAlign.start,color: Colors.white,),
                  SizedBox(height: 5,),
                  BodyText(text: text,align: TextAlign.start,color: Colors.white,)
                ],
              ),
            ),
          ),),
        ],
      ),
    );
  }

}
