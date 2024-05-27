class MovieModel {
  final String id;
  final String imgUrl;
  final String title;
  final String? releaseDate;
  final String? directorId;
  final int? directorAge;
  final String? directorName;

  const MovieModel({
    required this.id,
    required this.imgUrl,
    required this.title,
    this.releaseDate = '',
    this.directorId = '',
    this.directorAge = 0,
    this.directorName = '',
  });

  static MovieModel fromMap({required Map map}) => MovieModel(
        id: map['id'],
        imgUrl: map['imgUrl'],
        title: map['title'],
        releaseDate: map['releaseDate'],
        directorId: map['movieDirectorByMovieDirectorId']?['id'],
        directorAge: map['movieDirectorByMovieDirectorId']?['age'],
        directorName: map['movieDirectorByMovieDirectorId']?['name'],
      );

  static const empty = MovieModel(id: '', imgUrl: '', title: '');
}
