import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/api_end_points.dart';
import 'package:netflix/Domain/search/models/search_response/search_response.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/search/search_service.dart';

@LazySingleton(as: SearchService)
class SearchImpl implements SearchService {
  @override
  Future<Either<MainFailure, List<SearchResultData>>> searchMovies(
      {required String searchQuery}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {
          'query': searchQuery,
        },
      );
      //log('${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResponse.fromJson(response.data);
        final List<SearchResultData> searchList = [];
        for (final raw in result.results) {
          searchList.add(raw);
        }
        //log('${searchList[0].posterPath}');
        return Right(searchList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
