import 'package:mockito/mockito.dart';

extension on Invocation {
  String getDisplayString() {
    return '#$memberName(${positionalArguments.join(', ')})';
  }
}

mixin MockMixin on Mock {
  Future<T> mockFuture<T>(Invocation invocation) async {
    return super.noSuchMethod(
      invocation,
      returnValue:
          Future<T>.error('Missing stub for ${invocation.getDisplayString()}')
            ..ignore(),
      returnValueForMissingStub:
          Future<T>.error('Missing stub for ${invocation.getDisplayString()}')
            ..ignore(),
    ) as Future<T>;
  }
}
