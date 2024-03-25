import 'package:api_domain/api_domain.dart';

/// {@template api_session}
/// A session that contains a [User] and a [Session].
/// {@endtemplate}
class ApiSession {
  /// {@macro api_session}
  const ApiSession({
    required this.user,
    required this.session,
  });

  /// The user.
  final User user;

  /// The session.
  final Session session;
}
