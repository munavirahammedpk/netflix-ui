import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/new_and_hot/new_and_hot_service.dart';

import '../../Domain/new_and_hot/models/new_and_hot_respo/new_and_hot_respo.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewAndHotService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>(
      (event, emit) async {
        if(state.pastYearMovieList.isNotEmpty){
          emit(state);
          return;
        }
        //send loading to ui
        emit(state.copyWith(isError: false, isLoading: true));

        //get data
        final _movieResult = await _homeService.getHotAndNewMovieData();
        final _tvResult = await _homeService.getHotAndNewTvData();

        //transform data
        final newState_1 = _movieResult.fold(
          (failure) {
            return HomeState(
              stateId: DateTime.now().microsecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tenseDramasMovieList: [],
              southIndianMovieList: [],
              topTrendingTvList: [],
              isLoading: false,
              isError: true,
            );
          },
          (movieList) {
            final pastYearMovieList = movieList;
            final trendingMovieList = movieList;
            final tenseDramasMovieList = movieList;
            final southIndianMovieList = movieList;

            return HomeState(
              stateId: DateTime.now().microsecondsSinceEpoch.toString(),
              pastYearMovieList: pastYearMovieList,
              trendingMovieList: trendingMovieList,
              tenseDramasMovieList: tenseDramasMovieList,
              southIndianMovieList: southIndianMovieList,
              topTrendingTvList: state.topTrendingTvList,
              isLoading: false,
              isError: false,
            );
          },
        );
        emit(newState_1);
        final newState_2 = _tvResult.fold(
          (failure) {
            return HomeState(
                stateId: DateTime.now().microsecondsSinceEpoch.toString(),
                pastYearMovieList: [],
                trendingMovieList: [],
                tenseDramasMovieList: [],
                southIndianMovieList: [],
                topTrendingTvList: [],
                isLoading: false,
                isError: true);
          },
          (tvList) {
            return HomeState(
              stateId: DateTime.now().microsecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tenseDramasMovieList: state.tenseDramasMovieList,
              southIndianMovieList: state.southIndianMovieList,
              topTrendingTvList: tvList,
              isLoading: false,
              isError: false,
            );
          },
        );

        //send data to ui
        emit(newState_2);
      },
    );
  }
}
