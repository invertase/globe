import 'dart:math';

sealed class RPCRequestBase {}

abstract class MethodCall<T> implements RPCRequestBase {
  String get id => _getId();
  String get method;
  T get params;

  Map<String, dynamic> paramsToJson();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
      'params': paramsToJson(),
    };
  }
}

class Cancel extends RPCRequestBase {
  final String id;
  final String method = 'cancel';

  Cancel(this.id);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
    };
  }
}

final r = Random();

String _getId() {
  return (32000 + r.nextInt(100000)).toRadixString(16).padLeft(8, '0');
}

mixin JsonParams<T> on MethodCall<T> {
  @override
  Map<String, dynamic> paramsToJson() {
    // ignore: avoid_dynamic_calls
    return (params as dynamic).toJson() as Map<String, dynamic>;
  }
}

sealed class RPCResponse {
  RPCResponse();

  factory RPCResponse.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'success':
        return SuccessResponseWithResult.fromJson(json);
      case 'done':
        return DoneResponse.fromJson(json);
      case 'error':
        return ErrorResponse.fromJson(json);
      default:
        throw Exception('Unknown response type');
    }
  }
}

class SuccessResponseWithResult extends RPCResponse {
  final String id;
  final dynamic result;

  SuccessResponseWithResult(this.id, {required this.result});

  factory SuccessResponseWithResult.fromJson(Map<String, dynamic> json) {
    return SuccessResponseWithResult(
      json['id'] as String,
      result: json['result'],
    );
  }
}

class DoneResponse extends RPCResponse {
  final String id;
  final bool done;

  DoneResponse(this.id, {required this.done});

  factory DoneResponse.fromJson(Map<String, dynamic> json) {
    return DoneResponse(
      json['id'] as String,
      done: json['done'] as bool,
    );
  }
}

class RPCError {
  final String code;
  final String message;

  RPCError({required this.code, required this.message});

  factory RPCError.fromJson(Map<String, dynamic> json) {
    return RPCError(
      code: json['code'] as String,
      message: json['message'] as String,
    );
  }
}

class ErrorResponse extends RPCResponse {
  final String id;
  final RPCError error;

  ErrorResponse(this.id, {required this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['id'] as String,
      error: RPCError.fromJson(json['error'] as Map<String, dynamic>),
    );
  }
}
