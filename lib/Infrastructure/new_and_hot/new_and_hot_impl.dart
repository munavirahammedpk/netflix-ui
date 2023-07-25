import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/new_and_hot/models/new_and_hot_respo/new_and_hot_respo.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/new_and_hot/new_and_hot_service.dart';

import '../../Domain/core/api_end_points.dart';

@LazySingleton(as: NewAndHotService)
class HotAndNewImplemets implements NewAndHotService {
  @override
  Future<Either<MainFailure, List<NewAndHotResult>>>
      getHotAndNewMovieData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.newAndHotMovie
      );
      //log('${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotRespo.fromJson(response.data);
        final List<NewAndHotResult> newAndHotMovieList = [];
        for (final raw in result.results) {
          newAndHotMovieList.add(raw);
        }
        //log('${newAndHotMovieList[0].posterPath}');
        return Right(newAndHotMovieList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, List<NewAndHotResult>>>
      getHotAndNewTvData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.newAndHotTv
      );
      //log('${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotRespo.fromJson(response.data);
        final List<NewAndHotResult> newAndHotTvList = [];
        for (final raw in result.results) {
          newAndHotTvList.add(raw);
        }
        //log('${newAndHotTvList[0].posterPath}');
        return Right(newAndHotTvList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
