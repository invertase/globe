import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';

class SseResponse<T> {
  SseResponse({
    required this.request,
    required this.stream,
    required this.serializer,
  });

  late StreamSubscription<T> subscription;
  final Request request;
  final Stream<T> stream;
  final Function(T event) serializer;

  Response response() {
    // Create a new StreamController to manage the SSE events
    final controller = StreamController<String>();

    subscription = stream.listen(
      (data) {
        controller.add('data: ${jsonEncode({"result": serializer(data)})}\n\n');
      },
      onDone: () async {
        await controller.close();
      },
      onError: (error, stackTrace) async {
        controller.add(
          'event: error\ndata: ${jsonEncode({"error": error.toString()})}\n\n',
        );
        // TODO: Should we close the controller here?
      },
    );

    return Response.ok(
      controller.stream.transform(utf8.encoder),
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache, no-store, must-revalidate',
        'Pragma': 'no-cache',
        'Expires': '0',
        'Connection': 'keep-alive',
      },
    );
  }
}
