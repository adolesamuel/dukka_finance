import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ));
  }
}
