import 'package:flutter/material.dart';
import 'package:netflix/Presentation/widgets/text_icon.dart';
import 'package:netflix/core/constants.dart';

import '../../../core/colors/colors.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final int id;
  final String tvName;
  final String backdropPath;
  final String overview;

  const EveryonesWatchingWidget({
    super.key,
    required this.id,
    required this.tvName,
    required this.backdropPath,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        constHeight,
        Text(
          tvName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        constHeight,
        Text(
          overview,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: greyColor,
            fontSize: 16,
          ),
        ),
        constHeight,
        constHeight,
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('No image'),
                  );
                },
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                backgroundColor: Colors.black.withOpacity(.3),
                onPressed: (() {}),
                child: const Icon(
                  Icons.volume_off_sharp,
                  size: 25,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
        constHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            TextIcon(text: 'Share', icon: Icons.send),
            constWidth,
            TextIcon(text: 'My List', icon: Icons.add),
            constWidth,
            TextIcon(text: 'Play', icon: Icons.play_arrow),
            constWidth,
          ],
        )
      ],
    );
  }
}
