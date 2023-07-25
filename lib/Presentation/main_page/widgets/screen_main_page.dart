import 'package:flutter/material.dart';
import 'package:netflix/Presentation/downloads/widgets/screen_downloads.dart';
import 'package:netflix/Presentation/fast_laughs/screen_fast_laughs.dart';
import 'package:netflix/Presentation/home/screen_home.dart';
import 'package:netflix/Presentation/main_page/widgets/bottom_nav.dart';
import 'package:netflix/Presentation/new_and_hot.dart/screen_new_and_hot.dart';
import 'package:netflix/Presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pagesList = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaughs(),
    ScreenSearch(),
    ScreenDownloads()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, newIndex, _) {
            return _pagesList[newIndex];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
