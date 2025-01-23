import 'dart:convert';

import 'package:globe_functions/src/spec/sourced_function.dart';
import 'package:globe_functions/src/spec/sourced_imports.dart';

final class SpecWriter {
  final List<SourcedFunction> functions;
  final SourcedImports imports;
  final StringBuffer buffer = StringBuffer();

  SpecWriter({required this.functions, required this.imports});

  String write() {
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');

    buffer.writeln('const specs = ${const JsonEncoder.withIndent('  ').convert(functions)};');

    return buffer.toString();
  }
}
