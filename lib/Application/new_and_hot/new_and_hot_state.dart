part of 'new_and_hot_bloc.dart';

@freezed
class NewAndHotState with _$NewAndHotState {
  const factory NewAndHotState({
    required List<NewAndHotResult> comingSoonList,
    required List<NewAndHotResult> everyOnesWatching,
    required bool isLoading,
    required bool hasError,
  }) = _NewAndHotState;

  factory NewAndHotState.initial() => const NewAndHotState(
        comingSoonList: [],
        everyOnesWatching: [],
        isLoading: true,
        hasError: false,
      );
}
