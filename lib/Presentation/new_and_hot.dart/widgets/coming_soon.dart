import 'package:flutter/material.dart';
import 'package:netflix/Presentation/widgets/text_icon.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String movieName;
  final String backdropPath;
  final String month;
  final String day;
  final String overview;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.movieName,
    required this.backdropPath,
    required this.month,
    required this.day,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size - 60,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.network(
                      backdropPath,
                      fit: BoxFit.cover,
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
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -3,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      TextIcon(
                        text: 'Remind Me',
                        icon: Icons.notifications_none,
                      ),
                      constWidth,
                      TextIcon(
                        text: 'Info',
                        icon: Icons.info_outline_rounded,
                      ),
                      constWidth,
                    ],
                  ),
                ],
              ),
              constHeight,
              Text(
                'Coming on $day $month',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              constHeight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              constHeight,
              Text(
                overview,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: greyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
