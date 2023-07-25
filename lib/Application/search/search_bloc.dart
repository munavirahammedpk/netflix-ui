import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:netflix/Domain/downloads/i_downloads_repo.dart';
import 'package:netflix/Domain/downloads/models/downloads_response/downloads_response.dart';
import 'package:netflix/Domain/search/models/search_response/search_response.dart';
import 'package:netflix/Domain/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsService;
  final SearchService _searchService;

  SearchBloc(this._searchService, this._downloadsService)
      : super(SearchState.initial()) {
    // idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(state);
        return;
      }
      emit(
        const SearchState(
          isLoading: true,
          isError: false,
          idleList: [],
          searchResultList: [],
        ),
      );
      // get trending
      final _result = await _downloadsService.getDownloadsImages();
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            isLoading: false,
            isError: true,
            idleList: [],
            searchResultList: [],
          );
        },
        (List<DownloadsResultData> list) {
          return SearchState(
            isLoading: false,
            isError: false,
            idleList: list,
            searchResultList: [],
          );
        },
      );
      emit(_state);
      // show in ui
    });

    //search result state
    on<SearchMovie>((event, emit) async {
      // search movie from api
      emit(
        const SearchState(
          isLoading: true,
          isError: false,
          idleList: [],
          searchResultList: [],
        ),
      );
      final Either<MainFailure, List<SearchResultData>> result =
          await _searchService.searchMovies(searchQuery: event.searchQuery);
      final _state = result.fold(
        (MainFailure f) {
          return const SearchState(
            isLoading: false,
            isError: true,
            idleList: [],
            searchResultList: [],
          );
        },
        (List<SearchResultData> list) {
          return SearchState(
            isLoading: false,
            isError: false,
            idleList: [],
            searchResultList: list,
          );
        },
      );
      emit(_state);
      //show it in ui
    });
  }
}
