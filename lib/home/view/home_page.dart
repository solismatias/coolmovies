import 'package:coolmovies/home/home.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:coolmovies/utils/util_navigate.dart';
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
                Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return HomeMovieCard(
                        title: movie.title,
                        imageUrl: movie.imgUrl,
                        onTap: () {
                          UtilNavigate.to(context, MoviePage(movie: movie));
                        },
                      );
                    },
                  ),
                ),
              if (state.status == HomeMoviesStatus.failure) const Text('Something went wrong')
            ],
          ));
        },
      ),
    );
  }
}
