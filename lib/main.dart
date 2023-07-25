import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:netflix/Application/downloads/downloads_bloc.dart';
import 'package:netflix/Application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/Application/home/home_bloc.dart';
import 'package:netflix/Application/search/search_bloc.dart';
import 'package:netflix/Domain/core/di/injectable.dart';
import 'package:netflix/Presentation/main_page/widgets/screen_main_page.dart';
import 'package:netflix/core/colors/colors.dart';

import 'Application/new_and_hot/new_and_hot_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DownloadsBloc>(
          create: ((context) => getIt<DownloadsBloc>()),
        ),
        BlocProvider<SearchBloc>(
          create: ((context) => getIt<SearchBloc>()),
        ),
        BlocProvider<FastLaughBloc>(
          create: ((context) => getIt<FastLaughBloc>()),
        ),
        BlocProvider<NewAndHotBloc>(
          create: ((context) => getIt<NewAndHotBloc>()),
        ),
        BlocProvider<HomeBloc>(
          create: ((context) => getIt<HomeBloc>()),
        ),
        
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
            primarySwatch: Colors.blue,
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: backgroundColor,
            textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white))),
        home: ScreenMainPage(),
      ),
    );
  }
}
