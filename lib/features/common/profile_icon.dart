import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final void Function()? onPressed;
  const ProfileIcon({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const CircleAvatar(
        child: Icon(Icons.person),
      ),
    );
  }
}
