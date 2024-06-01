import 'package:coolmovies/common/widgets/widgets.dart';
import 'package:coolmovies/initial/initial.dart';
import 'package:coolmovies/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({required this.movieRepository, super.key});

  final MoviesRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: movieRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(movieRepository: context.read<MoviesRepository>())..add(const UserCurrentDataRequested()),
      child: MaterialApp(
        title: 'Cool Movies',
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFBB0A21),
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: const InitialPage(),
      ),
    );
  }
}
