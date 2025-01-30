import 'package:globe_functions/src/spec/rpc_procedure.dart';

class SourcedEntry {
  SourcedEntry({
    required this.importId,
    required this.name,
    required this.procedures,
  });

  /// The import ID of the entry.
  final int importId;

  /// The name of the entry.
  final String name;

  /// The procedures of the entry.
  final List<RpcProcedure> procedures;
}
