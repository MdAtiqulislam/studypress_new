
import 'package:flutter/material.dart';

import '../../constraints/app_colors.dart';


class AppButton extends StatelessWidget {

  double blurRadius;
  Widget child;
  VoidCallback? onTap;
  Offset? offset;
  Color bgColor;
  Color? shadowColor;
  double borderRadius;
  Color splashColor;
  double shadowOpacity;

  AppButton(
      {
        super.key,
        required this.bgColor,
        this.splashColor=AppColors.appSecondaryColor,
        required this.child,
        this.shadowColor = AppColors.appSecondaryColor,
        required this.onTap,
       // this.offset=const Offset(-3, 10),
        this.offset=const Offset(0, 3),
        this.blurRadius=5,
        this.borderRadius=10,
        this.shadowOpacity=.5
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          //color: bgColor,
          boxShadow: [
            BoxShadow(
                color: shadowColor!.withOpacity(shadowOpacity),
                spreadRadius: 0,
                blurRadius: blurRadius,
                offset: offset! // changes position of shadow
            ),
          ]
      ),
      child: Material(
        color: bgColor,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}




