import 'package:coolmovies/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(movieRepository: context.read<MoviesRepository>())..add(const HomeAllMoviesRequested()),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Center(
              child: Column(
            children: [
              const Text('Home Page'),
              if (state.status == HomeMoviesStatus.loading) const CircularProgressIndicator(),
              if (state.status == HomeMoviesStatus.success)
                Column(
                  children: [
                    for (var movie in state.movies) Text(movie.title),
                  ],
                ),
              if (state.status == HomeMoviesStatus.failure) const Text('Something went wrong')
            ],
          ));
        },
      ),
    );
  }
}
