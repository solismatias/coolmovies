class MovieModel {
  final String id;
  final String imgUrl;
  final String title;
  final String? releaseDate;
  final String? directorId;
  final int? directorAge;
  final String? directorName;
  final List<String>? reviewIds;

  const MovieModel({
    required this.id,
    required this.imgUrl,
    required this.title,
    this.releaseDate = '',
    this.directorId = '',
    this.directorAge = 0,
    this.directorName = '',
    this.reviewIds = const [],
  });

  static MovieModel fromMap({required Map map}) => MovieModel(
        id: map['id'],
        imgUrl: map['imgUrl'],
        title: map['title'],
        releaseDate: map['releaseDate'],
        directorId: map['movieDirectorByMovieDirectorId']?['id'],
        directorAge: map['movieDirectorByMovieDirectorId']?['age'],
        directorName: map['movieDirectorByMovieDirectorId']?['name'],
        reviewIds: _getReviewIds(map),
      );

  static const empty = MovieModel(id: '', imgUrl: '', title: '');
}

List<String> _getReviewIds(map) {
  List<String> reviewIds = [];
  if (map['movieReviewsByMovieId']?['edges'] == null) return reviewIds;
  for (var edge in map['movieReviewsByMovieId']?['edges']) {
    reviewIds.add(edge['node']['id']);
  }
  return reviewIds;
}
