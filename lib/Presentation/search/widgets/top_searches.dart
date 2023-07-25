import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

class TopSearchTileWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchTileWidget(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const Icon(
          Icons.play_circle_outline_sharp,
          color: whiteColor,
          size: 60,
        ),
      ],
    );
  }
}
