import 'package:bubble_trouble/utils/colors.dart';
import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  const MyPlayer({
    super.key,
    required this.playerX,
  });

  final double playerX;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.deepPurple,
            borderRadius: BorderRadius.circular(10)),
        height: 50,
        width: 50,
      ),
    );
  }
}