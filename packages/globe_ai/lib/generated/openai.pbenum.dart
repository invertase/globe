//
//  Generated code. Do not modify.
//  source: openai.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Compatibility extends $pb.ProtobufEnum {
  static const Compatibility STRICT = Compatibility._(0, _omitEnumNames ? '' : 'STRICT');
  static const Compatibility COMPATIBLE = Compatibility._(1, _omitEnumNames ? '' : 'COMPATIBLE');

  static const $core.List<Compatibility> values = <Compatibility> [
    STRICT,
    COMPATIBLE,
  ];

  static final $core.Map<$core.int, Compatibility> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Compatibility? valueOf($core.int value) => _byValue[value];

  const Compatibility._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
