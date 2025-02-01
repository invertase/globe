import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;

/// A class which is used to send an SSE response to the client.
class SseResponse<T> {
  /// Creates a new [SseResponse] instance.
  SseResponse({
    required this.request,
    required this.stream,
    required this.serializer,
  });

  /// The subscription to the stream.
  late StreamSubscription<T> subscription;

  /// The Shelf request.
  final shelf.Request request;

  /// The stream to send to the client.
  final Stream<T> stream;

  /// The serializer function for the stream events.
  final Function(T event) serializer;

  shelf.Response response() {
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

    return shelf.Response.ok(
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
