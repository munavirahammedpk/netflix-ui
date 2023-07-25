part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required bool isLoading,
    required bool isError,
    required List<DownloadsResultData> idleList,
    required List<SearchResultData> searchResultList,
  }) = _SearchState;

  factory SearchState.initial() => const SearchState(
        isLoading: true,
        isError: false,
        idleList: [],
        searchResultList: [],
      );
}
