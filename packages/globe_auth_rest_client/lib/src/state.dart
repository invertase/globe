import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';

sealed class GlobeAuthState {}

final class GlobeAuthStateLoading extends GlobeAuthState {}

final class GlobeAuthStateLoaded extends GlobeAuthState {
  GlobeAuthStateLoaded({required this.session, required this.user});

  final Session? session;
  final User? user;
}

final class GlobeAuthStateAuthenticated extends GlobeAuthState {
  GlobeAuthStateAuthenticated({required this.session, required this.user});

  final Session session;
  final User user;
}

final class GlobeAuthStateUnauthenticated extends GlobeAuthState {}
