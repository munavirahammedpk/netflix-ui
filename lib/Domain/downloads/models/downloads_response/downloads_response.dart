import 'package:json_annotation/json_annotation.dart';

part 'downloads_response.g.dart';

@JsonSerializable()
class DownloadsResponse {
  List<DownloadsResultData>? results;

  DownloadsResponse({
    this.results,
  });

  factory DownloadsResponse.fromJson(Map<String, dynamic> json) {
    return _$DownloadsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DownloadsResponseToJson(this);
}

@JsonSerializable()
class DownloadsResultData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  int? id;
  String? title;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'poster_path')
  String? posterPath;

  DownloadsResultData({
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.posterPath,
  });

  factory DownloadsResultData.fromJson(Map<String, dynamic> json) {
    return _$DownloadsResultDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DownloadsResultDataToJson(this);
}
