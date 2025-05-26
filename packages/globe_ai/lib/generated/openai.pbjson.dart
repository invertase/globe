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
    {
      '1': 'headers',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.OpenAIConfig.HeadersEntry',
      '10': 'headers'
    },
    {
      '1': 'compatibility',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.Compatibility',
      '10': 'compatibility'
    },
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

@$core.Deprecated('Use fileInputDescriptor instead')
const FileInput$json = {
  '1': 'FileInput',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'mime_type', '3': 2, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `FileInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileInputDescriptor = $convert.base64Decode(
    'CglGaWxlSW5wdXQSEgoEbmFtZRgBIAEoCVIEbmFtZRIbCgltaW1lX3R5cGUYAiABKAlSCG1pbW'
    'VUeXBlEhIKBGRhdGEYAyABKAxSBGRhdGE=');

@$core.Deprecated('Use textInputDescriptor instead')
const TextInput$json = {
  '1': 'TextInput',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `TextInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textInputDescriptor =
    $convert.base64Decode('CglUZXh0SW5wdXQSEgoEdGV4dBgBIAEoCVIEdGV4dA==');

@$core.Deprecated('Use openAIMessageDescriptor instead')
const OpenAIMessage$json = {
  '1': 'OpenAIMessage',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {
      '1': 'content',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.OpenAIInput',
      '10': 'content'
    },
  ],
};

/// Descriptor for `OpenAIMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openAIMessageDescriptor = $convert.base64Decode(
    'Cg1PcGVuQUlNZXNzYWdlEhIKBHJvbGUYASABKAlSBHJvbGUSJgoHY29udGVudBgCIAMoCzIMLk'
    '9wZW5BSUlucHV0Ugdjb250ZW50');

@$core.Deprecated('Use openAIMessagesDescriptor instead')
const OpenAIMessages$json = {
  '1': 'OpenAIMessages',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.OpenAIMessage',
      '10': 'messages'
    },
  ],
};

/// Descriptor for `OpenAIMessages`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openAIMessagesDescriptor = $convert.base64Decode(
    'Cg5PcGVuQUlNZXNzYWdlcxIqCghtZXNzYWdlcxgBIAMoCzIOLk9wZW5BSU1lc3NhZ2VSCG1lc3'
    'NhZ2Vz');

@$core.Deprecated('Use openAIInputDescriptor instead')
const OpenAIInput$json = {
  '1': 'OpenAIInput',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'text'},
    {
      '1': 'file',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.FileInput',
      '9': 0,
      '10': 'file'
    },
  ],
  '8': [
    {'1': 'input'},
  ],
};

/// Descriptor for `OpenAIInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openAIInputDescriptor = $convert.base64Decode(
    'CgtPcGVuQUlJbnB1dBIUCgR0ZXh0GAEgASgJSABSBHRleHQSIAoEZmlsZRgCIAEoCzIKLkZpbG'
    'VJbnB1dEgAUgRmaWxlQgcKBWlucHV0');

@$core.Deprecated('Use eitherMessagesOrPromptDescriptor instead')
const EitherMessagesOrPrompt$json = {
  '1': 'EitherMessagesOrPrompt',
  '2': [
    {'1': 'prompt', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'prompt'},
    {
      '1': 'messages',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.OpenAIMessages',
      '9': 0,
      '10': 'messages'
    },
  ],
  '8': [
    {'1': 'input'},
  ],
};

/// Descriptor for `EitherMessagesOrPrompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eitherMessagesOrPromptDescriptor = $convert.base64Decode(
    'ChZFaXRoZXJNZXNzYWdlc09yUHJvbXB0EhgKBnByb21wdBgBIAEoCUgAUgZwcm9tcHQSLQoIbW'
    'Vzc2FnZXMYAiABKAsyDy5PcGVuQUlNZXNzYWdlc0gAUghtZXNzYWdlc0IHCgVpbnB1dA==');
