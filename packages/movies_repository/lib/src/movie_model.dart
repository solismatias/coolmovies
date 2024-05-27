class MovieModel {
  final String id;
  final String imgUrl;
  final String title;
  final String? releaseDate;
  final String? directorId;
  final String? directorAge;
  final String? directorName;

  const MovieModel({
    required this.id,
    required this.imgUrl,
    required this.title,
    this.releaseDate = '',
    this.directorId = '',
    this.directorAge = '',
    this.directorName = '',
  });

  static MovieModel fromMap({required Map map}) => MovieModel(
        id: map['id'],
        imgUrl: map['imgUrl'],
        title: map['title'],
        releaseDate: map['releaseDate'],
        directorId: map['directorId'],
        directorAge: map['directorAge'],
        directorName: map['directorName'],
      );

  static const empty = MovieModel(id: '', imgUrl: '', title: '');
}
