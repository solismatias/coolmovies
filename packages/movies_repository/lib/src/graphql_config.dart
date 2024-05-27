import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    Platform.isAndroid ? 'http://10.0.2.2:5001/graphql' : 'http://localhost:5001/graphql',
  );

  GraphQLClient clientToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      );
}
