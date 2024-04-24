import 'package:dart_frog/dart_frog.dart';
import 'package:intl/intl.dart';

Response onRequest(RequestContext context) {
  final String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(
    DateTime.now(),
  );
  return Response(
    body: 'Welcome to hello_world REST API! Current time: $formattedDate',
  );
}
