import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50.0,
      width: 50.0,
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
