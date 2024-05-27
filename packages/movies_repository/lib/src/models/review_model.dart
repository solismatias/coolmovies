class ReviewModel {
  final String id;
  final String title;
  final String body;
  final int rating;
  final String movieId;
  final String userReviewerId;

  const ReviewModel({
    required this.id,
    required this.title,
    required this.body,
    required this.rating,
    required this.movieId,
    required this.userReviewerId,
  });

  static ReviewModel fromMap({required Map map}) => ReviewModel(
        id: map['id'],
        title: map['title'],
        body: map['body'],
        rating: map['rating'],
        movieId: map['movieId'],
        userReviewerId: map['userReviewerId'],
      );

  static const empty = ReviewModel(
    id: '',
    title: '',
    body: '',
    rating: 0,
    movieId: '',
    userReviewerId: '',
  );
}
