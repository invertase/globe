import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../utils/auth.dart';
import '../utils/metadata.dart';

/// A GraphQL client for the Globe API
class GlobeGraphQLClient {
  /// Creates a new GraphQL client for the Globe API
  GlobeGraphQLClient({
    required this.auth,
    required this.metadata,
  }) {
    _initClient();
  }

  /// The authentication service
  final GlobeAuth auth;

  /// The metadata service
  final GlobeMetadata metadata;

  /// The GraphQL client
  late final GraphQLClient client;

  /// Initialize the GraphQL client
  @visibleForTesting
  void _initClient() {
    final httpLink = HttpLink(
      '${metadata.endpoint}/graphql',
    );

    final authLink = AuthLink(
      getToken: () {
        final session = auth.currentSession;
        if (session == null) {
          return null;
        }

        if (session.authenticationMethod == AuthenticationMethod.jwt) {
          return 'Bearer ${session.jwt}';
        } else {
          return session.jwt;
        }
      },
    );

    final link = authLink.concat(httpLink);

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
