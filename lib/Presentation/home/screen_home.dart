import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Presentation/widgets/text_icon.dart';
import 'package:netflix/core/colors/colors.dart';
import '../../Application/home/home_bloc.dart';
import '../../core/constants.dart';
import '../widgets/main_title_card.dart';
import 'number_title_card.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        const GetHomeScreenData(),
      );
    });
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (context, newBool, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                //print(direction);
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.isError) {
                        return const Center(
                          child: Text('Error while getting data'),
                        );
                      }
                      //past year releases
                      final pastYearReleases = state.pastYearMovieList.map((e) {
                        return e.posterPath!;
                      }).toList();
                      //trending
                      final trending = state.trendingMovieList.map((e) {
                        return e.posterPath!;
                      }).toList();

                      //tense dramas
                      final dramas = state.tenseDramasMovieList.map((e) {
                        return e.posterPath!;
                      }).toList();

                      //South Indian Cinema
                      final southIndian = state.southIndianMovieList.map((e) {
                        return e.posterPath!;
                      }).toList();

                      //top 10 tv shows
                      final top10Tv = state.topTrendingTvList.map((e) {
                        return e.posterPath!;
                      }).toList();

                      pastYearReleases.shuffle();
                      trending.shuffle();
                      dramas.shuffle();
                      southIndian.shuffle();

                      return ListView(
                        children: [
                          const MainHomeCard(),
                          MainTitleCard(
                            posterPathList: pastYearReleases.sublist(0, 10),
                            size: size,
                            title: 'Released in the Past Year',
                          ),
                          constHeight,
                          MainTitleCard(
                            posterPathList: trending.sublist(0, 10),
                            size: size,
                            title: 'Trending Now',
                          ),
                          constHeight,
                          NumberTitleCard(
                            size: size,
                            posterPathList: top10Tv.sublist(0, 10),
                          ),
                          constHeight,
                          MainTitleCard(
                            posterPathList: dramas.sublist(0, 10),
                            size: size,
                            title: 'Tense Dramas',
                          ),
                          constHeight,
                          MainTitleCard(
                            posterPathList: southIndian.sublist(0, 10),
                            size: size,
                            title: 'South Indian Cinema',
                          ),
                        ],
                      );
                    },
                  ),
                  if (newBool)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                'https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png',
                                width: 70,
                                height: 60,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.network_check),
                                  );
                                },
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('TV Shows', style: constTextStyle),
                              Text('Movies', style: constTextStyle),
                              Text('Categories', style: constTextStyle)
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MainHomeCard extends StatelessWidget {
  const MainHomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 700,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(mainImage),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              TextIcon(
                text: 'My List',
                icon: Icons.add,
              ),
              _PlayButton(),
              TextIcon(
                text: 'Info',
                icon: Icons.info_outline,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(whiteColor),
      ),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
        color: blackColor,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Play',
          style: TextStyle(
            fontSize: 20,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
