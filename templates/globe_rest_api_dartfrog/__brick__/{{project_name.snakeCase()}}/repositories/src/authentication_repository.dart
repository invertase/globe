import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// {@template authentication_failure}
/// Exception throw when verification fails.
/// {@endtemplate}
class AuthenticationFailure implements Exception {
  /// {@macro authentication_failure}
  const AuthenticationFailure(this.message, this.stackTrace);

  /// The reason verification failed.
  final String message;

  /// The stack trace of the exception.
  final StackTrace? stackTrace;

  @override
  String toString() => 'AuthenticationFailure(message: $message)';
}

/// Function signature that builds a JWT.
typedef JWTBuilder = JWT Function(dynamic payload, {String? issuer});

/// Function signature that verifies a JWT.
typedef JWTVerifier = JWT Function(String token, JWTKey key);

/// {@template authentication_repository}
/// API's authentication repository.
///
/// Responsible for signing and validating user tokens.
///
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository({
    required String secret,
    required String issuer,
    JWTBuilder jwtBuilder = JWT.new,
    JWTVerifier jwtVerifier = JWT.verify,
  })  : _secret = secret,
        _issuer = issuer,
        _jwtBuilder = jwtBuilder,
        _jwtVerifier = jwtVerifier;

  final String _secret;
  final String _issuer;
  final JWTBuilder _jwtBuilder;
  final JWTVerifier _jwtVerifier;

  /// Signs a payload into a token.
  String sign(Map<String, dynamic> payload) {
    final jwt = _jwtBuilder(payload, issuer: _issuer);
    return jwt.sign(SecretKey(_secret));
  }

  /// Verifies a token and returns the payload.
  Map<String, dynamic> verify(String token) {
    try {
      final jwt = _jwtVerifier(token, SecretKey(_secret));
      return jwt.payload as Map<String, dynamic>;
    } catch (e, s) {
      throw AuthenticationFailure(e.toString(), s);
    }
  }
}
