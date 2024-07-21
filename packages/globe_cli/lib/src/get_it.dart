import 'package:get_it/get_it.dart';

extension GetItX on GetIt {
  /// Initialize a singleton if it is not already registered.
  ///
  /// This is mainly useful for tests, where tests register overrides
  /// for singletons.
  T singletonPutIfAbsent<T extends Object>(T Function() value) {
    if (!isRegistered<T>()) {
      registerSingleton<T>(value());
    }

    return get<T>();
  }
}
