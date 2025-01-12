import 'package:coolmovies/common/constants/app_layout.dart';
import 'package:coolmovies/common/widgets/widgets.dart';
import 'package:coolmovies/movie/movie.dart';
import 'package:coolmovies/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_repository/movies_repository.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
    required this.movieId,
  }) : super(key: key);
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(movieRepository: context.read<MoviesRepository>())
        ..add(MovieDataRequested(id: movieId))
        ..add(MovieReviewsRequested(id: movieId)),
      child: Scaffold(
          appBar: const MyAppBar(),
          body: MultiBlocListener(
            listeners: [
              // Reviews Sync Listener
              BlocListener<MovieBloc, MovieState>(
                listenWhen: (prevState, currentState) {
                  return ((prevState.reviewSubmitStatus != currentState.reviewSubmitStatus));
                },
                listener: (context, state) {
                  if (state.reviewSubmitStatus == MovieStatus.success) {
                    showFeedback(true, successMessage: 'Review submited successfully');
                    context.read<MovieBloc>().add(
                          MovieReviewsRequested(id: movieId, forceReload: true),
                        );
                  } else if (state.reviewSubmitStatus == MovieStatus.failure) {
                    showFeedback(
                      false,
                      errorMessage: 'Connection Lost: your review will auto submitted when reconnected',
                      color: Colors.amber[900],
                    );
                  }
                },
              ),
              // Review Delete Listener
              BlocListener<MovieBloc, MovieState>(
                listenWhen: (prevState, currentState) {
                  return ((prevState.reviewDeleteStatus != currentState.reviewDeleteStatus));
                },
                listener: (context, state) {
                  if (state.reviewDeleteStatus == MovieStatus.success) {
                    showFeedback(true, successMessage: 'Review removed successfully');
                    context.read<MovieBloc>().add(
                          MovieReviewsRequested(id: movieId, forceReload: true),
                        );
                  } else if (state.reviewDeleteStatus == MovieStatus.failure) {
                    showFeedback(false);
                  }
                },
              ),
              // Review Submit Listener
              BlocListener<MovieBloc, MovieState>(
                listenWhen: (prevState, currentState) {
                  return ((prevState.syncSuccess != currentState.syncSuccess && currentState.syncSuccess));
                },
                listener: (context, state) {
                  showFeedback(true, successMessage: 'You are online again: Reviews added successfully');
                  context.read<MovieBloc>().add(
                        MovieReviewsRequested(id: movieId, forceReload: true),
                      );
                },
              ),
            ],
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state.status == MovieStatus.loading) const _Loader(),
                      if (state.status == MovieStatus.failure)
                        NoConnection(
                          onRetryPressed: () {
                            context.read<MovieBloc>().add(MovieDataRequested(id: movieId));
                            context.read<MovieBloc>().add(MovieReviewsRequested(id: movieId));
                          },
                        ),
                      if (state.status == MovieStatus.success)
                        Column(
                          children: [
                            _MoviePoster(imgUrl: state.movie.imgUrl),
                            Padding(
                              padding: const EdgeInsets.all(AppLayout.padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Title(movie: state.movie),
                                  const SizedBox(height: AppLayout.spacingSmall),
                                  if (state.reviewStatus == MovieStatus.success)
                                    RatingSquare(ratings: state.reviews.map((review) => review.rating).toList()),
                                  const SizedBox(height: AppLayout.spacingSmall),
                                  _MoreInfo(movie: state.movie),
                                  const SizedBox(height: AppLayout.spacingSmall),
                                  const Divider(),
                                  if (state.reviewStatus == MovieStatus.success) _Reviews(state: state),
                                  if (state.reviewStatus == MovieStatus.loading) const _Loader(),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({required this.state});
  final MovieState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ReviewHeader(state: state),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.reviews.length,
          itemBuilder: (context, index) {
            final review = state.reviews[index];
            return MovieReviewCard(
              review: review,
              onDeletePressed: () async {
                bool confirmAction = await showConfirmModal(context);
                if (review.id != null && confirmAction && context.mounted) {
                  context.read<MovieBloc>().add(
                        MovieReviewsDeletePressed(
                          reviewId: review.id!,
                        ),
                      );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _ReviewHeader extends StatelessWidget {
  const _ReviewHeader({required this.state});
  final MovieState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
          child: const Text(
            'Reviews',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            ReviewModel? newReview = await showAddReviewModal(
              context: context,
              movieId: state.movie.id,
            );
            if (newReview != null && context.mounted) {
              context.read<MovieBloc>().add(MovieReviewsSubmitPressed(review: newReview));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "Add a review",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: AppLayout.padding * 2),
              child: SizedBox(
                width: 80,
                height: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.movie});
  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: movie.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' (${UtilDate.getYear(movie.releaseDate)})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreInfo extends StatefulWidget {
  const _MoreInfo({required this.movie});
  final MovieModel movie;
  @override
  State<_MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<_MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      children: [
        ExpansionPanelRadio(
          value: 'more_info',
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text(
                'More info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          body: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.all(AppLayout.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Release Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      widget.movie.releaseDate ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: AppLayout.spacingSmall),
                    const Text(
                      'Director:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      widget.movie.directorName ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      widget.movie.directorAge != null ? '${widget.movie.directorAge} years old' : 'Age not available',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppLayout.padding / 2),
          child: MyShimmer(width: MediaQuery.of(context).size.width, height: 400),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppLayout.padding / 2),
          child: MyShimmer(width: MediaQuery.of(context).size.width, height: 400),
        ),
      ],
    );
  }
}
