import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/core/failures/main_failures.dart';
import 'package:netflix/Domain/downloads/models/downloads_response/downloads_response.dart';

abstract class IDownloadsRepo {
  Future<Either<MainFailure, List<DownloadsResultData>>> getDownloadsImages();
}
