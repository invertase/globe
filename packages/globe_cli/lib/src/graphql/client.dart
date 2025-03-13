import 'package:graphql/client.dart';

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
  void _initClient() {
    final httpLink = HttpLink('${metadata.endpoint}/graphql');

    final authLink = AuthLink(
      headerKey: switch (auth.currentSession?.authenticationMethod) {
        AuthenticationMethod.apiToken => 'x-api-token',
        _ => 'Authorization',
      },
      getToken: () {
        final currentSession = auth.currentSession;
        if (currentSession == null) {
          return null;
        }

        return 'Bearer ${currentSession.jwt}';
      },
    );

    final link = authLink.concat(httpLink);

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
