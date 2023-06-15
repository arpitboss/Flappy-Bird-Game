import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {

  final size;

  const Barriers({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xffECC19C),
        border: Border.all(width: 10.0, color: Colors.brown),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
