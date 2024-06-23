// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bubble_trouble/utils/colors.dart';

class MyButton extends StatelessWidget {
  final icon;
   void Function() onTap;
   MyButton({
    Key? key,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
         color: AppColor.grey100,
         borderRadius: BorderRadius.circular(10)
        ),
        height: 50,
        width: 50,
       
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }
}
