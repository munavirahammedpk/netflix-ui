import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class NumberCard extends StatelessWidget {
  const NumberCard(
      {super.key,
      required this.size,
      required this.index,
      required this.imageUrl});
  final double size;
  final int index;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: size * 1 / 2,
            ),
            Container(
              width: size * 1 / 3,
              height: size * 1 / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          bottom: -15,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: whiteColor,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                decoration: TextDecoration.none,
                color: blackColor,
                fontSize: 120,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
