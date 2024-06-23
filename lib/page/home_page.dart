import 'dart:async';

import 'package:bubble_trouble/utils/colors.dart';
import 'package:bubble_trouble/widgets/ball.dart';
import 'package:bubble_trouble/widgets/button.dart';
import 'package:bubble_trouble/widgets/missile.dart';
import 'package:bubble_trouble/widgets/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT, UP, DOWN }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;
  double missileX = playerX;
  double missileY = 1;
  double ballX = 0.5;
  double ballY = 1;
  double missileHeight = 10;
  bool midShot = false;
  double velocity = 60; //how strong the jump is
  var ballDirection = direction.LEFT;

  void moveLeft() {
    if (playerX >= -0.9) {
      setState(() {
        playerX -= 0.1;
        if (!midShot) {
          missileX = playerX;
        }
      });
    }
  }

  void moveRight() {
    if (playerX <= 0.9) {
      setState(() {
        playerX += 0.1;
        if (!midShot) {
          missileX = playerX;
        }
      });
    }
  }

  void fireMissiles() {
    if (midShot == false) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        midShot = true;
        setState(() {
          missileHeight += 10;
        });
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }

        if (ballY > heightToPosition(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  void resetMissile() {
    setState(() {
      missileX = playerX;
      missileHeight = 10;
      midShot = false;
    });
  }

  void startGame() {
    double time = 0;
    double height = 0;

    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      height = -5 * time * time + velocity * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        ballY = heightToPosition(height);
      });

      if (ballX - 0.005 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.005 >= 1) {
        ballDirection = direction.LEFT;
      }

      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.005;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.005;
        });
      }
      if (playerDies()) {
        timer.cancel();
        _showDialog();
      }
      time += 0.1;
    });
  }

  double heightToPosition(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  bool playerDies() {
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColor.grey,
            title: const Center(child: Text("You Dead BRO",style: TextStyle(color: Colors.white),)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissiles();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: AppColor.pink100,
                  child: Center(
                      child: Stack(
                    children: [
                      Ball(ballX: ballX, ballY: ballY),
                      MyMissile(
                          missileX: missileX,
                          missileY: missileY,
                          missileHeight: missileHeight),
                      MyPlayer(playerX: playerX),
                    ],
                  )),
                )),
            Expanded(
                child: Container(
              color: AppColor.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    onTap: startGame,
                    icon: Icons.play_arrow,
                  ),
                  MyButton(
                    onTap: moveLeft,
                    icon: Icons.arrow_back,
                  ),
                  MyButton(
                    onTap: fireMissiles,
                    icon: Icons.arrow_upward,
                  ),
                  MyButton(
                    onTap: moveRight,
                    icon: Icons.arrow_forward,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
