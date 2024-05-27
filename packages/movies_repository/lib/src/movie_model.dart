class MovieModel {
  final String id;
  final String imgUrl;
  final String title;

  const MovieModel({
    required this.id,
    required this.imgUrl,
    required this.title,
  });

  static MovieModel fromMap({required Map map}) => MovieModel(
        id: map['id'],
        imgUrl: map['imgUrl'],
        title: map['title'],
      );

  static const empty = MovieModel(id: '', imgUrl: '', title: '');
}
