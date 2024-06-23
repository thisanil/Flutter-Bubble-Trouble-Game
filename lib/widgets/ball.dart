import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({
    super.key,
    required this.ballX,
    required this.ballY,
  });

  final double ballX;
  final double ballY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 10,
        width: 10,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.brown),
      ),
    );
  }
}
