class ReviewModel {
  final String? id;
  final String title;
  final String body;
  final int rating;
  final String movieId;
  final String userReviewerId;
  final String userReviewerName;

  const ReviewModel({
    this.id,
    required this.title,
    required this.body,
    required this.rating,
    required this.movieId,
    required this.userReviewerId,
    this.userReviewerName = '',
  });

  static ReviewModel fromMap({required Map map}) => ReviewModel(
        id: map['id'],
        title: map['title'],
        body: map['body'],
        rating: map['rating'],
        movieId: map['movieId'],
        userReviewerId: map['userByUserReviewerId']['id'] ?? '',
        userReviewerName: map['userByUserReviewerId']['name'] ?? '',
      );

  static const empty = ReviewModel(
    id: '',
    title: '',
    body: '',
    rating: 0,
    movieId: '',
    userReviewerId: '',
    userReviewerName: '',
  );
}
