import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class TextIcon extends StatelessWidget {
  const TextIcon({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: whiteColor,
        ),
        Text(text,style:const TextStyle(
          fontSize: 12,
        ),),
      ],
    );
  }
}
