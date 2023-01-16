import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  const EmptyWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Lottie.asset("assets/empty_lottie.json"),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24.0),
          )
        ],
      ),
    );
  }
}
