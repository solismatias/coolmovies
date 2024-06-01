import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/home/home.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:coolmovies/common/utils/util_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:coolmovies/user/bloc/user_bloc.dart';
import 'package:coolmovies/common/widgets/widgets.dart';

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
      appBar: const MyAppBar(showBackButton: false),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppLayout.padding),
            child: Center(
                child: Column(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Text(state.user.name);
                  },
                ),
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
                          onAddReviewPressed: () async {
                            ReviewModel? newReview = await showAddReviewModal(
                              context: context,
                              movieId: movie.id,
                            );
                          },
                          onMoreButtonPressed: () {
                            UtilNavigate.to(context, MoviePage(movieId: movie.id));
                          },
                        );
                      },
                    ),
                  ),
                if (state.status == HomeMoviesStatus.failure) const Text('Something went wrong')
              ],
            )),
          );
        },
      ),
    );
  }
}
