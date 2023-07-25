import 'package:json_annotation/json_annotation.dart';

part 'new_and_hot_respo.g.dart';

@JsonSerializable()
class NewAndHotRespo {
  @JsonKey(name: 'results')
  List<NewAndHotResult> results;

  NewAndHotRespo({this.results=const []});

  factory NewAndHotRespo.fromJson(Map<String, dynamic> json) {
    return _$NewAndHotRespoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewAndHotRespoToJson(this);
}

@JsonSerializable()
class NewAndHotResult {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  int? id;

  @JsonKey(name:'title')
  String? title;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  //use in case of tv data
  @JsonKey(name: 'original_name')
  String? originalName;
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;

  NewAndHotResult({
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.originalName,
  });

  factory NewAndHotResult.fromJson(Map<String, dynamic> json) {
    return _$NewAndHotResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewAndHotResultToJson(this);
}
