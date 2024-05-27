class MovieModel {
  final String id;
  final String imgUrl;
  final String title;

  MovieModel({
    required this.id,
    required this.imgUrl,
    required this.title,
  });

  static MovieModel fromMap({required Map map}) => MovieModel(
        id: map['id'],
        imgUrl: map['imgUrl'],
        title: map['title'],
      );
}
