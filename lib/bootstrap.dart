import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coolmovies/app/app.dart';
import 'package:coolmovies/app/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_repository/movies_repository.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final movieRepository = MoviesRepository();

  runZonedGuarded(
    () => runApp(App(
      movieRepository: movieRepository,
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
