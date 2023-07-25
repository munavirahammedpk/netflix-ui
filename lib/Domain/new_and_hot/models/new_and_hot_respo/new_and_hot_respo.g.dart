// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_and_hot_respo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAndHotRespo _$NewAndHotRespoFromJson(Map<String, dynamic> json) =>
    NewAndHotRespo(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => NewAndHotResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NewAndHotRespoToJson(NewAndHotRespo instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

NewAndHotResult _$NewAndHotResultFromJson(Map<String, dynamic> json) =>
    NewAndHotResult(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      originalName: json['original_name'] as String?,
    );

Map<String, dynamic> _$NewAndHotResultToJson(NewAndHotResult instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
    };
