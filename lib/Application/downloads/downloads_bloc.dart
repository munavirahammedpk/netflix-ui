import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:netflix/Domain/downloads/i_downloads_repo.dart';
import 'package:netflix/Domain/downloads/models/downloads_response/downloads_response.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;
  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.initial()) {
    on<_getDownloadsImages>((event, emit) async {
      if (state.downloads.isNotEmpty) {
        emit(state);
        return;
      }
      emit(state.copyWith(
        isLoading: true,
        downloadsFailureOrSuccess: none(),
      ));

      final Either<MainFailure, List<DownloadsResultData>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();

      emit(
        downloadsOption.fold(
          (failure) => state.copyWith(
            isLoading: false,
            downloadsFailureOrSuccess: Some(left(failure)),
          ),
          (success) => state.copyWith(
              isLoading: false,
              downloads: success,
              downloadsFailureOrSuccess: Some(right(success))),
        ),
      );
    });
  }
}
