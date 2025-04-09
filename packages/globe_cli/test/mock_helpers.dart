import 'package:mockito/mockito.dart';

extension on Invocation {
  String getDisplayString() {
    return '#$memberName(${positionalArguments.join(', ')})';
  }
}

extension MockMixin on Mock {
  Future<T> mockFuture<T>(Invocation invocation) async {
    final voidFuture = Future<void>.value();

    return noSuchMethod(
      invocation,
      returnValue: (voidFuture is Future<T>)
          ? voidFuture
          : Future<T>.error('Missing stub for ${invocation.getDisplayString()}')
        ..ignore(),
      returnValueForMissingStub: (voidFuture is Future<T>)
          ? voidFuture
          : Future<T>.error('Missing stub for ${invocation.getDisplayString()}')
        ..ignore(),
    ) as Future<T>;
  }

  T nsm<T>(Invocation invocation, Object? returnValue) {
    return noSuchMethod(invocation, returnValue: returnValue) as T;
  }
}
