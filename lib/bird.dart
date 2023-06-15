import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(height: 40.0, width: 40.0, 'assets/flappy_bird.png');
  }
}
