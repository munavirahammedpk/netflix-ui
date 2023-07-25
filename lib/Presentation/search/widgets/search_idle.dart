import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Application/search/search_bloc.dart';
import 'package:netflix/Presentation/search/widgets/title.dart';
import 'package:netflix/Presentation/search/widgets/top_searches.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        constHeight,
        constHeight,
        Expanded(
          child:
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isError) {
              return const Center(
                child: Text('Error while getting Data'),
              );
            } else if (state.idleList.isEmpty) {
              return const Center(
                child: Text('Search list is empty'),
              );
            } else {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final movie = state.idleList[index];
                    return TopSearchTileWidget(
                        title: '${movie.originalTitle ?? 'No Title Provided'}',
                        imageUrl: '$imageBaseUrl${movie.backdropPath}');
                  }),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                  itemCount: state.idleList.length);
            }
          }),
        ),
      ],
    );
  }
}
