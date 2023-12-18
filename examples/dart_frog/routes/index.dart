import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  print('We have logs!');
  return Response(body: 'Welcome to Dart Frog running on Globe!');
}
