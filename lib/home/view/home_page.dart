import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/common/utils/utils.dart';
import 'package:coolmovies/home/home.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:coolmovies/common/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        movieRepository: context.read<MoviesRepository>(),
      )..add(const HomeAllMoviesRequested()),
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
                if (state.status == HomeMoviesStatus.loading) const _Loader(),
                if (state.status == HomeMoviesStatus.failure)
                  NoConnection(
                    onRetryPressed: () {
                      context.read<HomeBloc>().add(const HomeAllMoviesRequested());
                    },
                  ),
                if (state.status == HomeMoviesStatus.success)
                  Expanded(
                    child: Column(
                      children: [
                        _Header(state: state),
                        _Movies(state: state),
                      ],
                    ),
                  ),
              ],
            )),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'All Movies',
          style: TextStyle(fontSize: 18),
        ),
        DropdownButton<String>(
          value: state.sortBy,
          focusColor: Colors.black,
          underline: const SizedBox(),
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.padding),
          items: ['newest', 'oldest'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(UtilText.capitalize(value)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<HomeBloc>().add(HomeSortMoviewsRequested(sortBy: value));
            }
          },
        )
      ],
    );
  }
}

class _Movies extends StatelessWidget {
  const _Movies({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              if (newReview != null && context.mounted) {
                context.read<MovieBloc>().add(MovieReviewsSubmitPressed(review: newReview));
              }
            },
            onMoreButtonPressed: () {
              UtilNavigate.to(context, MoviePage(movieId: movie.id));
            },
          );
        },
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppLayout.padding / 2),
            child: MyShimmer(width: MediaQuery.of(context).size.width, height: 400),
          );
        },
      ),
    );
  }
}
