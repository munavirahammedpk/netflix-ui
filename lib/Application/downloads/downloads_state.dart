part of 'downloads_bloc.dart';

@freezed
class DownloadsState with _$DownloadsState {
  const factory DownloadsState({
    required bool isLoading,
    required List<DownloadsResultData> downloads,
    required Option<Either<MainFailure, List<DownloadsResultData>>>
        downloadsFailureOrSuccess,
  }) = _DownloadsState;

  factory DownloadsState.initial() {
    return const DownloadsState(
      isLoading: true,
      downloadsFailureOrSuccess: None(),
      downloads: [],
    );
  }
}
