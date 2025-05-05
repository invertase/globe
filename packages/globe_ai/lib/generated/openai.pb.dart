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

import 'openai.pbenum.dart';

export 'openai.pbenum.dart';

/// Configuration message for the OpenAI provider
class OpenAIConfig extends $pb.GeneratedMessage {
  factory OpenAIConfig({
    $core.String? baseUrl,
    $core.String? apiKey,
    $core.String? name,
    $core.String? organization,
    $core.String? project,
    $core.Map<$core.String, $core.String>? headers,
    Compatibility? compatibility,
  }) {
    final $result = create();
    if (baseUrl != null) {
      $result.baseUrl = baseUrl;
    }
    if (apiKey != null) {
      $result.apiKey = apiKey;
    }
    if (name != null) {
      $result.name = name;
    }
    if (organization != null) {
      $result.organization = organization;
    }
    if (project != null) {
      $result.project = project;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (compatibility != null) {
      $result.compatibility = compatibility;
    }
    return $result;
  }
  OpenAIConfig._() : super();
  factory OpenAIConfig.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OpenAIConfig.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenAIConfig',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'baseUrl')
    ..aOS(2, _omitFieldNames ? '' : 'apiKey')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'organization')
    ..aOS(5, _omitFieldNames ? '' : 'project')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'headers',
        entryClassName: 'OpenAIConfig.HeadersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS)
    ..e<Compatibility>(
        7, _omitFieldNames ? '' : 'compatibility', $pb.PbFieldType.OE,
        defaultOrMaker: Compatibility.STRICT,
        valueOf: Compatibility.valueOf,
        enumValues: Compatibility.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OpenAIConfig clone() => OpenAIConfig()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OpenAIConfig copyWith(void Function(OpenAIConfig) updates) =>
      super.copyWith((message) => updates(message as OpenAIConfig))
          as OpenAIConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenAIConfig create() => OpenAIConfig._();
  OpenAIConfig createEmptyInstance() => create();
  static $pb.PbList<OpenAIConfig> createRepeated() =>
      $pb.PbList<OpenAIConfig>();
  @$core.pragma('dart2js:noInline')
  static OpenAIConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenAIConfig>(create);
  static OpenAIConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBaseUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get apiKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set apiKey($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasApiKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearApiKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get organization => $_getSZ(3);
  @$pb.TagNumber(4)
  set organization($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOrganization() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrganization() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get project => $_getSZ(4);
  @$pb.TagNumber(5)
  set project($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasProject() => $_has(4);
  @$pb.TagNumber(5)
  void clearProject() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get headers => $_getMap(5);

  @$pb.TagNumber(7)
  Compatibility get compatibility => $_getN(6);
  @$pb.TagNumber(7)
  set compatibility(Compatibility v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCompatibility() => $_has(6);
  @$pb.TagNumber(7)
  void clearCompatibility() => clearField(7);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
