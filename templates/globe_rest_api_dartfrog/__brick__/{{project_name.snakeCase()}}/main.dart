import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:db_client/db_client.dart';
import 'package:api_domain/api_domain.dart';
import 'package:{{project_name.snakeCase()}}/adapters/adapters.dart';

late final DbClient _dbClient;
late final AuthenticationRepository _authenticationRepository;
late final PostRepository _postRepository;

Future<void> init(InternetAddress ip, int port) async {
  _dbClient = DbClient();
  _authenticationRepository = AuthenticationRepository(
    secret: _secret,
    issuer: _issuer,
  );

  _postRepository = PostRepository(
    adapter: APIPostRepositoryAdapter(
      dbClient: _dbClient,
    ),
  );
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  return serve(
    handler
        .use(
          provider<DbClient>((_) => _dbClient),
        )
        .use(
          provider<AuthenticationRepository>((_) => _authenticationRepository),
        )
        .use(
          provider<PostRepository>((_) => _postRepository),
        ),
    ip,
    port,
  );
}

String get _secret {
  final value = Platform.environment['SECRET'];
  if (value == null) {
    stdout.writeln('No secret provided, running with development settings');
    return 'two is not one, which is not three, but is a number';
  }
  return value;
}

String get _issuer {
  final value = Platform.environment['ISSUER'];
  if (value == null) {
    stdout.writeln('No issuer provided, running with development settings');
    return 'https://localhost:8080';
  }
  return value;
}
