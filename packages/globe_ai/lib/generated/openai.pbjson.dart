//
//  Generated code. Do not modify.
//  source: openai.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use compatibilityDescriptor instead')
const Compatibility$json = {
  '1': 'Compatibility',
  '2': [
    {'1': 'STRICT', '2': 0},
    {'1': 'COMPATIBLE', '2': 1},
  ],
};

/// Descriptor for `Compatibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List compatibilityDescriptor = $convert.base64Decode(
    'Cg1Db21wYXRpYmlsaXR5EgoKBlNUUklDVBAAEg4KCkNPTVBBVElCTEUQAQ==');

@$core.Deprecated('Use openAIConfigDescriptor instead')
const OpenAIConfig$json = {
  '1': 'OpenAIConfig',
  '2': [
    {'1': 'base_url', '3': 1, '4': 1, '5': 9, '10': 'baseUrl'},
    {'1': 'api_key', '3': 2, '4': 1, '5': 9, '10': 'apiKey'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'organization', '3': 4, '4': 1, '5': 9, '10': 'organization'},
    {'1': 'project', '3': 5, '4': 1, '5': 9, '10': 'project'},
    {'1': 'headers', '3': 6, '4': 3, '5': 11, '6': '.OpenAIConfig.HeadersEntry', '10': 'headers'},
    {'1': 'compatibility', '3': 7, '4': 1, '5': 14, '6': '.Compatibility', '10': 'compatibility'},
  ],
  '3': [OpenAIConfig_HeadersEntry$json],
};

@$core.Deprecated('Use openAIConfigDescriptor instead')
const OpenAIConfig_HeadersEntry$json = {
  '1': 'HeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `OpenAIConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openAIConfigDescriptor = $convert.base64Decode(
    'CgxPcGVuQUlDb25maWcSGQoIYmFzZV91cmwYASABKAlSB2Jhc2VVcmwSFwoHYXBpX2tleRgCIA'
    'EoCVIGYXBpS2V5EhIKBG5hbWUYAyABKAlSBG5hbWUSIgoMb3JnYW5pemF0aW9uGAQgASgJUgxv'
    'cmdhbml6YXRpb24SGAoHcHJvamVjdBgFIAEoCVIHcHJvamVjdBI0CgdoZWFkZXJzGAYgAygLMh'
    'ouT3BlbkFJQ29uZmlnLkhlYWRlcnNFbnRyeVIHaGVhZGVycxI0Cg1jb21wYXRpYmlsaXR5GAcg'
    'ASgOMg4uQ29tcGF0aWJpbGl0eVINY29tcGF0aWJpbGl0eRo6CgxIZWFkZXJzRW50cnkSEAoDa2'
    'V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

