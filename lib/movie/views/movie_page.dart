import 'package:coolmovies/home/home.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:coolmovies/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(movieRepository: context.read<MoviesRepository>())
        ..add(MovieDataRequested(id: movie.id))
        ..add(MovieReviewsRequested(id: movie.id)),
      child: Scaffold(body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return Column(
            children: [
              const Text('Movie Page'),
              if (state.status == MovieStatus.loading) const CircularProgressIndicator(),
              if (state.status == MovieStatus.failure) const Text('Something went wrong'),
              if (state.status == MovieStatus.success)
                Expanded(
                  child: Column(
                    children: [
                      HomeMovieCard(
                        imageUrl: state.movie.imgUrl,
                        title: state.movie.title,
                        onTap: () {},
                      ),
                      const Text('release date:'),
                      Text(state.movie.releaseDate ?? ''),
                      const Text('director:'),
                      Text(state.movie.directorName ?? ''),
                      Text(state.movie.directorAge.toString()),
                      BackButton(onPressed: () => UtilNavigate.goBack(context)),
                      const Text('Reviews:'),
                      if (state.reviewStatus == MovieStatus.success)
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.reviews.length,
                            itemBuilder: (context, index) {
                              final review = state.reviews[index];
                              return MovieReviewCard(
                                title: review.title,
                                body: review.body,
                                rating: review.rating,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      )),
    );
  }
}
