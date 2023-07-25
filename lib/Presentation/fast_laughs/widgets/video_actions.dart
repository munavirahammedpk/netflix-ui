import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix/core/colors/colors.dart';

class VideoActionswidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const VideoActionswidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: whiteColor,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: whiteColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
