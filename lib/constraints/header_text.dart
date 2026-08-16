import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dimensions.dart';


class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;
  final int maxLine;
  final double? size;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final bool resizeable;
  const HeaderText({super.key,
    required this.text,
    this.color=const Color(0xFF261A3D),
    this.textOverflow=TextOverflow.ellipsis,
    this.fontWeight=FontWeight.bold,
    this.align=TextAlign.center,
    this.maxLine=1,
    this.size,
    this.resizeable=true
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize:resizeable? size?.sp??AppDimensions.headerTextSize.sp:size??AppDimensions.headerTextSize,
        fontWeight: fontWeight,
      ),
    );
  }
}