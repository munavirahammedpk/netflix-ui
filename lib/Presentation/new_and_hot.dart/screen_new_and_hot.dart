import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix/Presentation/new_and_hot.dart/widgets/coming_soon.dart';
import 'package:netflix/Presentation/new_and_hot.dart/widgets/everyones_watching.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

import '../../Application/new_and_hot/new_and_hot_bloc.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New & Hot',
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.w800),
          ),
          actions: [
            const Icon(
              Icons.cast,
              size: 30,
              color: whiteColor,
            ),
            constWidth,
            Container(
              width: 30,
              height: 20,
              color: Colors.blue,
            ),
            constWidth,
          ],
          bottom: TabBar(
              isScrollable: true,
              labelColor: blackColor,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelColor: whiteColor,
              indicator: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              tabs: const [
                Tab(
                  text: '🍿 Coming Soon',
                ),
                Tab(
                  text: "👀 Everyone's Watching",
                ),
              ]),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TabBarView(
              children: [
                ComingSoonListWidget(),
                EveryoneIsWatchingListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ComingSoonListWidget extends StatelessWidget {
  const ComingSoonListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewAndHotBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<NewAndHotBloc, NewAndHotState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading data'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('Coming Soon List is empty'),
            );
          } else {
            return ListView.builder(
              itemCount: state.comingSoonList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final movieData = state.comingSoonList[index];
                if (movieData.id == null) {
                  return const SizedBox();
                }
                String month;
                String day;
                try {
                  final _date = DateTime.tryParse(movieData.releaseDate!);
                  final formatedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  month = formatedDate.split(' ').first.substring(
                        0,
                        3,
                      );
                  day = movieData.releaseDate!.split('-').elementAt(1);
                } catch (_) {
                  month = '';
                  day = '';
                }

                return ComingSoonWidget(
                  id: movieData.id.toString(),
                  movieName: movieData.originalTitle ?? 'No Title',
                  backdropPath: '$imageBaseUrl${movieData.backdropPath}',
                  month: month,
                  day: day,
                  overview: movieData.overview ?? 'No Description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingListWidget extends StatelessWidget {
  const EveryoneIsWatchingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<NewAndHotBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<NewAndHotBloc, NewAndHotState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading data'),
            );
          } else if (state.everyOnesWatching.isEmpty) {
            return const Center(
              child: Text('Everyone is Watching List is empty'),
            );
          } else {
            return ListView.builder(
              padding:EdgeInsets.all(5),
              itemCount: state.everyOnesWatching.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tvData = state.everyOnesWatching[index];
                return EveryonesWatchingWidget(
                  id: tvData.id!,
                  tvName: tvData.originalName ?? 'No Title',
                  backdropPath: '$imageBaseUrl${tvData.backdropPath}',
                  overview: tvData.overview ?? 'No Description',
                );
              },
            );
          }
        },
      ),
    );
  }
}
