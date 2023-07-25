import 'package:flutter/material.dart';
import 'package:netflix/Presentation/widgets/main_card.dart';
import 'package:netflix/core/strings.dart';
import '../../core/constants.dart';
import 'main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard(
      {Key? key,
      required this.size,
      required this.title,
      required this.posterPathList})
      : super(key: key);

  final double size;
  final String title;
  final List<String> posterPathList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: MainTitle(title: title),
        ),
        constHeight,
        LimitedBox(
          maxHeight: size * 1 / 2,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterPathList.length,
              (index) {
                return MainCard(
                  size: size,
                  imageUrl: '$imageBaseUrl${posterPathList[index]}',
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
