import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movies_repository/src/graphql_config.dart';
import 'package:movies_repository/src/models/movie_model.dart';
import 'package:movies_repository/src/models/review_model.dart';

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
              movieReviewsByMovieId {
                  edges {
                      node {
                          id
                      }
                  }
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
      return MovieModel.fromMap(map: movieData);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ReviewModel>> getMovieReviews(String movieId) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          document: gql("""
          query MyQuery(\$id: UUID!) {
            allMovieReviews(condition: {movieId: \$id}) {
              edges {
                node {
                  id
                  body
                  movieId
                  rating
                  title
                  userReviewerId
                }
              }
            }
          }
          """),
          variables: {
            'id': movieId,
          },
        ),
      );

      if (result.hasException) throw Exception(result.exception);

      List reviewData = result.data!['allMovieReviews']['edges'] ?? [];

      List<ReviewModel> reviews = [];

      for (var review in reviewData) {
        reviews.add(ReviewModel.fromMap(map: review['node']));
      }

      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }
}
