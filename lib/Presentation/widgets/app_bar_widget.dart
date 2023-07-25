import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        constWidth,
        Text(
          title,
          style:
              GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          size: 30,
          color: whiteColor,
        ),
        constWidth,
        Container(
          width: 30,
          height: 30,
          color: Colors.blue,
        ),
        constWidth,
      ],
    );
  }
}
