import 'package:flutter/material.dart';

class DrawerContentWidgets extends StatelessWidget {
  final String text;
  final Widget icon;
  DrawerContentWidgets({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
