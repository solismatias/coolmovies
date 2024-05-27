import 'package:flutter/material.dart';
import 'package:movies_repository/movies_repository.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text('Movie Page'),
        Text(movie.title),
      ],
    ));
  }
}
