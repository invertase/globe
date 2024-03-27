import 'package:dart_frog/dart_frog.dart';
import 'package:provider/provider.dart';
import '../../repositories/repositories.dart';
import '../../services/db_client.dart';
import '../../middlewares/middlewares.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(corsHeaders())
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
