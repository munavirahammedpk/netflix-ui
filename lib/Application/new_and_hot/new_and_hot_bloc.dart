import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/new_and_hot/models/new_and_hot_respo/new_and_hot_respo.dart';
import 'package:netflix/Domain/new_and_hot/new_and_hot_service.dart';

import '../../Domain/core/failures/main_failures.dart';

part 'new_and_hot_event.dart';
part 'new_and_hot_state.dart';
part 'new_and_hot_bloc.freezed.dart';

@injectable
class NewAndHotBloc extends Bloc<NewAndHotEvent, NewAndHotState> {
  final NewAndHotService _newAndHotService;
  NewAndHotBloc(this._newAndHotService) : super(NewAndHotState.initial()) {
    on<LoadDataInComingSoon>(
      (event, emit) async {
        if (state.comingSoonList.isNotEmpty) {
          emit(state);
          return;
        }
        emit(
          const NewAndHotState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: true,
              hasError: false),
        );
        //get new and hot movie data
        final _result = await _newAndHotService.getHotAndNewMovieData();
        final _newState = _result.fold(
          (MainFailure failure) => const NewAndHotState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: false,
              hasError: true),
          (List<NewAndHotResult> list) => NewAndHotState(
              comingSoonList: list,
              everyOnesWatching: state.everyOnesWatching,
              isLoading: false,
              hasError: false),
        );
        emit(_newState);
      },
    );

    //get new and hot tv data
    on<LoadDataInEveryoneIsWatching>(
      (event, emit) async {
        if (state.everyOnesWatching.isNotEmpty) {
          emit(state);
          return;
        }
        emit(
          const NewAndHotState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: true,
              hasError: false),
        );
        final _result = await _newAndHotService.getHotAndNewTvData();
        //log(_result.toString());
        final newState = _result.fold(
          (MainFailure failure) => const NewAndHotState(
              comingSoonList: [],
              everyOnesWatching: [],
              isLoading: false,
              hasError: true),
          (List<NewAndHotResult> list) => NewAndHotState(
              comingSoonList: state.comingSoonList,
              everyOnesWatching: list,
              isLoading: false,
              hasError: false),
        );
        emit(newState);
      },
    );
  }
}
