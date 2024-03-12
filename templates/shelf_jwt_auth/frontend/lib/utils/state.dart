import 'package:flutter/material.dart';
import 'dart:async';

import '../data/services.dart';

enum ProviderState { idle, loading, success, error }

class ProviderEvent<T> {
  final T? data;
  final ProviderState state;
  final String? errorMessage;

  const ProviderEvent.idle()
      : state = ProviderState.idle,
        data = null,
        errorMessage = null;

  const ProviderEvent.loading({this.data})
      : state = ProviderState.loading,
        errorMessage = null;

  const ProviderEvent.success({required this.data})
      : state = ProviderState.success,
        errorMessage = null;

  const ProviderEvent.error({required this.errorMessage})
      : state = ProviderState.error,
        data = null;
}

mixin DataStreamMixin<T> {
  final _streamController = StreamController<T>.broadcast();

  /// access the stream
  Stream<T> get stream => _streamController.stream;

  /// access the sink
  @protected
  Sink<T> get sink => _streamController.sink;

  ///
  T? _lastEvent;

  /// access the last event sent into the stream
  T? get lastEvent => _lastEvent;

  /// adds an event into the stream
  /// also stores is as a [lastEvent]
  /// and notifies state
  @protected
  void addEvent(T event) {
    _lastEvent = event;
    sink.add(event);
  }

  /// clear lastevent
  void clear() {
    _lastEvent = null;
  }

  /// close the stream
  void dispose() {
    _streamController.close();
  }
}

abstract class BaseProvider<T> extends ChangeNotifier
    with DataStreamMixin<ProviderEvent<T>> {
  ProviderState? get state => lastEvent?.state;

  bool get isLoading => state == ProviderState.loading;

  bool get hasError => state == ProviderState.error;

  String? get errorMessage => lastEvent?.errorMessage;

  @override
  void clear() {
    super.clear();
    addEvent(const ProviderEvent.idle());
  }

  Future<Result?> safeRun<Result>(FutureOr<Result> Function() apiCall) async {
    addEvent(const ProviderEvent.loading());

    try {
      return await apiCall.call();
    } on ApiException catch (e) {
      addEvent(ProviderEvent.error(errorMessage: e.errors.join('\n')));
      return null;
    }
  }
}
