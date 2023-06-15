import 'dart:async';
import 'package:flappy_bird_game/barriers.dart';
import 'package:flappy_bird_game/bird.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  int score = 0;
  int bestScore = 0;
  double initialHeight = birdYaxis;
  bool gamehasStarted = false;
  static double barrierX1 = 2.0;
  double barrierX2 = barrierX1 + 1.5;

  void jump() {
    setState(() {
      time = 0;
      score += 1;
      initialHeight = birdYaxis;
    });
    if (score >= bestScore) {
      bestScore = score;
    }
  }

  bool birdIsDead() {
    if (birdYaxis > 1 || birdYaxis < -1) {
      return true;
    } else {
      return false;
    }
  }

  void startGame() {
    gamehasStarted = true;
    score = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        setState(() {
          if (barrierX1 < -1.1) {
            barrierX1 += 2.2;
          } else {
            barrierX1 -= 0.05;
          }
        });

        if (birdIsDead()) {
          timer.cancel();
          _showDialog();
        }

        setState(() {
          if (barrierX2 < -1.1) {
            barrierX2 += 2.2;
          } else {
            barrierX2 -= 0.05;
          }
        });
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gamehasStarted = false;
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gamehasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Image.asset('assets/flappy-bird-game-over.jpg'),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: const Text(
                      '  Start Again  ',
                      style: TextStyle(
                        color: Color(0xffECC19C),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gamehasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(children: [
              AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                color: Colors.lightBlueAccent,
                duration: const Duration(milliseconds: 0),
                child: const Bird(),
              ),
              Container(
                  alignment: const Alignment(0, -0.65),
                  child: gamehasStarted
                      ? const Text('')
                      : Image.asset(
                          'assets/play_button_flappy.png',
                          height: 300,
                        )),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierX1, 1.1),
                child: const Barriers(
                  size: 200.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierX1, -1.3),
                child: const Barriers(
                  size: 200.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierX2, 1.2),
                child: const Barriers(
                  size: 150.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierX2, -1.2),
                child: const Barriers(
                  size: 250.0,
                ),
              ),
            ]),
          ),
          Container(
            height: 10.0,
            color: const Color(0xffecC09C),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Image.asset(
                        'assets/scorecard_flappy.png',
                        width: 80.0,
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      const Text(
                        'SCORE',
                        style: TextStyle(
                            color: Color(0xffECC19C),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        score.toString(),
                        style: const TextStyle(
                            color: Color(0xffECC19C),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Image.asset(
                        'assets/trophy_flappy.png',
                        width: 78.0,
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        bestScore.toString(),
                        style: const TextStyle(
                            color: Color(0xffECC19C),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
