import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    Key? key,
    required this.size,
    required this.imageUrl,
  }) : super(key: key);

  final double size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: size * 1 / 3,
        height: size * 1 / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          image:  DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                imageUrl),
          ),
        ),
      ),
    );
  }
}
