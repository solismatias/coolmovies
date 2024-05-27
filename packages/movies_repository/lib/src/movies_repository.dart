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

      List res = result.data!['allMovies'] ?? [];

      if (result.hasException) throw Exception(result.exception);

      List<MovieModel> movies = [];

      for (var movie in res) {
        movies.add(MovieModel.fromMap(map: movie));
      }

      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }
}
