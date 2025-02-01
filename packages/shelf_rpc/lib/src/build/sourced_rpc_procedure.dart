import 'package:shelf_rpc/src/build/supported_type.dart';
import 'package:shelf_rpc/src/build/sourced_rpc_procedure_parameter.dart';

/// A class representing a sourced RPC procedure from the user's code.
final class SourcedRpcProcedure {
  /// The id of the procedure (derived from the symbol / parents).
  final String id;

  /// The interface of the procedure.
  final SupportedType interface;

  /// The parameters of the procedure.
  final Iterable<SourcedRpcProcedureParameter> parameters;

  /// Creates a new [SourcedRpcProcedure] instance.
  SourcedRpcProcedure({
    required this.id,
    required this.interface,
    required this.parameters,
  });

  /// The reconstructed typedef of the procedure.
  String get typedef {
    final b = StringBuffer();

    final positional = parameters.where((p) => p.isPositional && !p.isOptional);
    final optional = parameters.where((p) => p.isPositional && p.isOptional);
    final named = parameters.where((p) => p.isNamed);

    b.writeln('${interface.typeDefinition} Function(');

    b.write(positional.map((p) => p.typedef).join(', '));

    if (optional.isNotEmpty) {
      if (positional.isNotEmpty) b.write(', ');
      b.write('[${optional.map((p) => p.typedef).join(', ')}]');
    }

    if (named.isNotEmpty) {
      if (positional.isNotEmpty || optional.isNotEmpty) b.write(', ');
      b.write(
        '{${named.map((p) => '${p.isRequired ? 'required ' : ''}${p.typedef}').join(', ')}}',
      );
    }

    b.writeln(')');

    return b.toString();
  }
}
