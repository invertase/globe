import 'package:shelf_rpc/src/build/sourced_rpc_procedure.dart';

/// A class representing a single entrypoint in the generated code.
class SourcedEntrypoint {
  /// Creates a new [SourcedEntrypoint] instance.
  SourcedEntrypoint({
    required this.importId,
    required this.name,
    required this.procedures,
  });

  /// The import ID of the entry.
  final int importId;

  /// The name of the entrypoint/top-level variable.
  final String name;

  /// The procedures of the entry.
  final List<SourcedRpcProcedure> procedures;
}
