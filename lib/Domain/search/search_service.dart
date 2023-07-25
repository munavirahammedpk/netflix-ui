import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:netflix/Domain/search/models/search_response/search_response.dart';

abstract class SearchService {
  Future<Either<MainFailure, List<SearchResultData>>> searchMovies({
    required String searchQuery,
  });
}
