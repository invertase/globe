import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(
    DateTime.now(),
  );
  return Response(
    body: 'Welcome to {{project_name}} REST API! Current time: $formattedDate',
  );
}
