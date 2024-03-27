import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

/// Middleware that checks if the request authentication is valid.
///
/// And sets the session in the request context if so.
Middleware authenticationValidator() => bearerAuthentication<ApiSession>(
      authenticator: (context, token) async {
        final authenticationReposity = context.read<AuthenticationRepository>();
        final session = Session.fromJson(authenticationReposity.verify(token));

        final userRepository = context.read<UserRepository>();
        final user = await userRepository.findUserById(session.userId);

        if (user != null) {
          return ApiSession(user: user, session: session);
        }

        return null;
      },
    );