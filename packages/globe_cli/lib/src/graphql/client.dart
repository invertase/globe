import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../utils/auth.dart';
import '../utils/metadata.dart';

/// A GraphQL client for the Globe API
class GlobeGraphQLClient {
  /// Creates a new GraphQL client for the Globe API
  GlobeGraphQLClient() {
    _initClient();
  }

  /// The authentication service
  GlobeAuth get _auth => GetIt.instance.get();

  /// The metadata service
  GlobeMetadata get metadata => GetIt.instance.get();

  /// The GraphQL client
  late final GraphQLClient client;

  /// Initialize the GraphQL client
  void _initClient() {
    final httpLink = HttpLink('${metadata.endpoint}/graphql');

    final authLink = AuthLink(
      headerKey: switch (_auth.currentSession?.authenticationMethod) {
        AuthenticationMethod.apiToken => 'x-api-token',
        _ => 'Authorization',
      },
      getToken: () => switch (_auth.currentSession?.authenticationMethod) {
        AuthenticationMethod.apiToken => _auth.currentSession!.jwt,
        AuthenticationMethod.jwt => 'Bearer ${_auth.currentSession!.jwt}',
        _ => null,
      },
    );

    final link = authLink.concat(httpLink);

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
