import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink('http://localhost:5001/graphql');
  // static HttpLink httpLink = HttpLink('http://192.168.1.35:5001/graphql');

  GraphQLClient clientToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      );
}
