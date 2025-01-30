import 'package:globe_functions/src/spec/rpc_procedure_parameter.dart';
import 'package:globe_functions/src/spec/types.dart';

class RpcProcedure {
  final String id;
  final SupportedType interface;
  final Iterable<RpcProcedureParameter> parameters;

  RpcProcedure({
    required this.id,
    required this.interface,
    required this.parameters,
  });

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
