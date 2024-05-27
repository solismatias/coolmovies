import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movies_repository/src/graphql_config.dart';
import 'package:movies_repository/src/movie_model.dart';

class MoviesRepository {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<MovieModel>> getMovies() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          document: gql("""
        query MyQuery {
          allMovies {
            edges {
              node {
                id
                imgUrl
                title
                }
              }
            }
          }
        """),
        ),
      );

      List res = result.data!['allMovies']['edges'] ?? [];

      if (result.hasException) throw Exception(result.exception);

      List<MovieModel> movies = [];

      for (var movie in res) {
        movies.add(MovieModel.fromMap(map: movie['node']));
      }

      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieModel> getMovie(String id) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          document: gql("""
          query MyQuery(\$id: UUID!) {
            movieById(id: \$id) {
              id
              imgUrl
              title
              releaseDate
              movieDirectorByMovieDirectorId {
                age
                id
                name
              }
            }
          }
          """),
          variables: {
            'id': id,
          },
        ),
      );

      if (result.hasException) throw Exception(result.exception);

      var movieData = result.data!['movieById'];
      print(movieData);
      return MovieModel.fromMap(map: movieData);
    } catch (e) {
      throw Exception(e);
    }
  }
}
