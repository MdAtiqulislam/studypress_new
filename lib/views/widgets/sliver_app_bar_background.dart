import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constraints/app_colors.dart';

class SliverAppBarBackground extends StatelessWidget {
  const SliverAppBarBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child:Image.asset("assets/icons/open-book.png",)
        ),
        Positioned(
          top: -50,
          right: 0,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                shape: BoxShape.circle

            ),
          )
          ,),
        Positioned(
            top: 0,
            left: 50,
            child: Image.asset("assets/moc_icons/moc_icons_0.png",width: 50,height: 50,)),
        Positioned(
            top: 100,
            left: 20,
            child: Image.asset("assets/moc_icons/moc_icons_1.png",width: 50,height: 50,)),
        Positioned(
            bottom: 0,
            right: 10,
            child: Image.asset("assets/moc_icons/moc_icons_1.png",width: 50,height: 50,)),
        Positioned(
          top: 100.h,
          right: 100.w,
          child: Image.asset("assets/moc_icons/moc_icons_3.png",width: 50,height: 50,),),

        Container(color: Colors.white.withOpacity(.7),),
      ],
    );
  }
}
