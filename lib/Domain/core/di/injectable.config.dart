// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:netflix/Application/downloads/downloads_bloc.dart' as _i9;
import 'package:netflix/Application/fast_laugh/fast_laugh_bloc.dart' as _i10;
import 'package:netflix/Application/home/home_bloc.dart' as _i11;
import 'package:netflix/Application/new_and_hot/new_and_hot_bloc.dart' as _i12;
import 'package:netflix/Application/search/search_bloc.dart' as _i13;
import 'package:netflix/Domain/downloads/i_downloads_repo.dart' as _i3;
import 'package:netflix/Domain/new_and_hot/new_and_hot_service.dart' as _i5;
import 'package:netflix/Domain/search/search_service.dart' as _i7;
import 'package:netflix/Infrastructure/downloads/downloads_repository.dart'
    as _i4;
import 'package:netflix/Infrastructure/new_and_hot/new_and_hot_impl.dart'
    as _i6;
import 'package:netflix/Infrastructure/search/search_impl.dart' as _i8;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IDownloadsRepo>(() => _i4.DownloadsRepository());
  gh.lazySingleton<_i5.NewAndHotService>(() => _i6.HotAndNewImplemets());
  gh.lazySingleton<_i7.SearchService>(() => _i8.SearchImpl());
  gh.factory<_i9.DownloadsBloc>(
      () => _i9.DownloadsBloc(gh<_i3.IDownloadsRepo>()));
  gh.factory<_i10.FastLaughBloc>(
      () => _i10.FastLaughBloc(gh<_i3.IDownloadsRepo>()));
  gh.factory<_i11.HomeBloc>(() => _i11.HomeBloc(gh<_i5.NewAndHotService>()));
  gh.factory<_i12.NewAndHotBloc>(
      () => _i12.NewAndHotBloc(gh<_i5.NewAndHotService>()));
  gh.factory<_i13.SearchBloc>(() => _i13.SearchBloc(
        gh<_i7.SearchService>(),
        gh<_i3.IDownloadsRepo>(),
      ));
  return getIt;
}
