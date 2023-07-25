// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadsResponse _$DownloadsResponseFromJson(Map<String, dynamic> json) =>
    DownloadsResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DownloadsResultData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DownloadsResponseToJson(DownloadsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

DownloadsResultData _$DownloadsResultDataFromJson(Map<String, dynamic> json) =>
    DownloadsResultData(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      posterPath: json['poster_path'] as String?,
    );

Map<String, dynamic> _$DownloadsResultDataToJson(
        DownloadsResultData instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
    };
