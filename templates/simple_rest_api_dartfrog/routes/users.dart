import 'package:dart_frog/dart_frog.dart';

final users = [
  {"name": 'tobi'},
  {"name": 'loki'},
  {"name": 'jane'}
];

Response onRequest(RequestContext context) {
  return Response.json(body: users);
}
