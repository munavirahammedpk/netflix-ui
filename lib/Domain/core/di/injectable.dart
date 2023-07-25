import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureInjection() async {
  init(getIt, environment: Environment.prod);
}
