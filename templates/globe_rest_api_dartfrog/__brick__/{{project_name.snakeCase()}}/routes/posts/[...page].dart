import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String page) {
  return Response(body: 'post page: $page');
}
