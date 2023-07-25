import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:netflix/Domain/new_and_hot/models/new_and_hot_respo/new_and_hot_respo.dart';

abstract class NewAndHotService {
  Future<Either<MainFailure, List<NewAndHotResult>>> getHotAndNewMovieData();
  Future<Either<MainFailure, List<NewAndHotResult>>> getHotAndNewTvData();
}
