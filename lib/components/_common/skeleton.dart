import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

enum EnumType { RECTANGLE, CIRCLE }

class Skeleton extends StatelessWidget {
  final int width;
  final int height;
  final EnumType type;

  const Skeleton(
      {Key key, @required this.width, @required this.height, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white70,
      child: Container(
        width: ScreenUtil().setWidth(width),
        height: ScreenUtil().setHeight(height),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                type == EnumType.CIRCLE ? height.toDouble() : 0)),
      ),
    );
  }
}
