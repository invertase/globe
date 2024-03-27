import 'package:dart_frog/dart_frog.dart';
import 'package:provider/provider.dart';
import '../repositories/repositories.dart';
import '../services/db_client.dart';
import '../middlewares/middlewares.dart';

Handler middleware(Handler handler) {
  return handler
      {{#if include_authentication}}
      .use(authenticationValidator())
      {{/if}}
      {{#if enable_cors}}
      .use(corsHeaders())
      {{/if}}
      {{#if include_logging}}
      .use(requestLogger())
      {{/if}}
      .use(
        provider<SessionRepository>(
          (context) => SessionRepository(dbClient: context.read<DbClient>()),
        ),
      )
      .use(
        provider<UserRepository>(
          (context) => UserRepository(dbClient: context.read<DbClient>()),
        ),
      );
}
