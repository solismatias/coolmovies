import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movies_repository/movies_repository.dart';

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
                releaseDate
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

  Future<List<ReviewModel>> getMovieReviews(String movieId, {bool forceReload = false}) async {
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
                  userByUserReviewerId {
                    name
                    id
                  }
                }
              }
            }
          }
          """),
          variables: {
            'id': movieId,
          },
          fetchPolicy: forceReload ? null : FetchPolicy.networkOnly,
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

  Future<bool> createMovieReview(ReviewModel review) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
        document: gql("""
          mutation MyMutation(
            \$title: String!, 
            \$movieId: UUID!, 
            \$userReviewerId: UUID!, 
            \$rating: Int!, 
            \$body: String!, 
            \$clientMutationId: String!) {
              createMovieReview(input: 
                {movieReview: 
                  {title: \$title, 
                  movieId: \$movieId, 
                  userReviewerId: \$userReviewerId, 
                  rating: \$rating, 
                  body: \$body
                }, 
                clientMutationId: \$clientMutationId}) 
                {clientMutationId}
          }
        """),
        variables: {
          'title': review.title,
          'movieId': review.movieId,
          'userReviewerId': review.userReviewerId,
          'rating': review.rating,
          'body': review.body,
          'clientMutationId': "${DateTime.now().millisecondsSinceEpoch}",
        },
      ));

      if (result.hasException) throw Exception(result.exception);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          document: gql("""
          query MyQuery {
            currentUser {
              name
              id
            }
          }
          """),
        ),
      );

      if (result.hasException) throw Exception(result.exception);

      var userData = result.data!['currentUser'];
      UserModel user = UserModel.fromMap(map: userData);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteMovieReview(String reviewId) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql("""
            mutation MyMutation(\$id: UUID!) {
              deleteMovieReviewById(input: {id: \$id}) {
                clientMutationId
              }
            }
          """),
          variables: {
            'id': reviewId,
          },
        ),
      );

      if (result.hasException) throw Exception(result.exception);

      return true;
    } catch (e) {
      return false;
    }
  }
}
