import 'package:bubble_trouble/utils/colors.dart';
import 'package:flutter/material.dart';

class MyMissile extends StatelessWidget {
  const MyMissile({
    super.key,
    required this.missileX,
    required this.missileY,
    required this.missileHeight,
  });

  final double missileX;
  final double missileY;
  final double missileHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        decoration: BoxDecoration(
            color:AppColor.grey100,
            borderRadius: BorderRadius.circular(10)),
        height: missileHeight,
        width: 2,
      ),
    );
  }
}