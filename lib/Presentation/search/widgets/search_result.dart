import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Application/search/search_bloc.dart';
import 'package:netflix/Presentation/search/widgets/title.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchTextTitle(
          title: 'Movies & TV',
        ),
        constHeight,
        constHeight,
        Expanded(
          child:
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state.searchResultList.isEmpty) {
              return const Center(
                child: Text('Search List is Empty'),
              );
            } else {
              return GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.6,
                shrinkWrap: true,
                children: List.generate(
                  state.searchResultList.length,
                  (index) {
                    final movie = state.searchResultList[index];
                    return MainCard(
                        posterPath: '$imageBaseUrl${movie.posterPath}');
                  },
                ),
              );
            }
          }),
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.posterPath});
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.network(
        posterPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text('No image'),
          );
        },
      ),
    );
  }
}
