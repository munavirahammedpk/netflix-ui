import 'package:flutter/material.dart';
import 'package:netflix/Presentation/home/number_card.dart';
import 'package:netflix/Presentation/widgets/main_title.dart';

import '../../core/constants.dart';
import '../../core/strings.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.size,
    required this.posterPathList,
  }) : super(key: key);

  final double size;
  final List<String> posterPathList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: MainTitle(title: 'Top 10 TV Shows in India Today'),
        ),
        constHeight,
        LimitedBox(
          maxHeight: size * 1 / 2,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterPathList.length,
              (index) => NumberCard(
                imageUrl: '$imageBaseUrl${posterPathList[index]}',
                size: size,
                index: index,
              ),
            ),
          ),
        )
      ],
    );
  }
}
