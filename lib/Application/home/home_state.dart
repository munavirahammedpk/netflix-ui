part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<NewAndHotResult> pastYearMovieList,
    required List<NewAndHotResult> trendingMovieList,
    required List<NewAndHotResult> tenseDramasMovieList,
    required List<NewAndHotResult> southIndianMovieList,
    required List<NewAndHotResult> topTrendingTvList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory HomeState.initial() =>const HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tenseDramasMovieList: [],
      southIndianMovieList: [],
      topTrendingTvList: [],
      isLoading: true,
      isError: false);
}
