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

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion$json = {
  '1': 'ChatCompletion',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'object', '3': 2, '4': 1, '5': 9, '10': 'object'},
    {'1': 'created', '3': 3, '4': 1, '5': 13, '10': 'created'},
    {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    {'1': 'choices', '3': 5, '4': 3, '5': 11, '6': '.ChatCompletion.Choices', '10': 'choices'},
    {'1': 'usage', '3': 6, '4': 1, '5': 11, '6': '.ChatCompletion.Usage', '10': 'usage'},
    {'1': 'service_tier', '3': 7, '4': 1, '5': 9, '10': 'serviceTier'},
    {'1': 'system_fingerprint', '3': 8, '4': 1, '5': 9, '10': 'systemFingerprint'},
  ],
  '3': [ChatCompletion_Message$json, ChatCompletion_Choices$json, ChatCompletion_Prompt_tokens_details$json, ChatCompletion_Completion_tokens_details$json, ChatCompletion_Usage$json],
};

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion_Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'role', '3': 1, '4': 1, '5': 9, '10': 'role'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'refusal', '3': 3, '4': 1, '5': 9, '10': 'refusal'},
  ],
};

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion_Choices$json = {
  '1': 'Choices',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 13, '10': 'index'},
    {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.ChatCompletion.Message', '10': 'message'},
    {'1': 'finish_reason', '3': 3, '4': 1, '5': 9, '10': 'finishReason'},
  ],
};

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion_Prompt_tokens_details$json = {
  '1': 'Prompt_tokens_details',
  '2': [
    {'1': 'cached_tokens', '3': 1, '4': 1, '5': 13, '10': 'cachedTokens'},
    {'1': 'audio_tokens', '3': 2, '4': 1, '5': 13, '10': 'audioTokens'},
  ],
};

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion_Completion_tokens_details$json = {
  '1': 'Completion_tokens_details',
  '2': [
    {'1': 'reasoning_tokens', '3': 1, '4': 1, '5': 13, '10': 'reasoningTokens'},
    {'1': 'audio_tokens', '3': 2, '4': 1, '5': 13, '10': 'audioTokens'},
    {'1': 'accepted_prediction_tokens', '3': 3, '4': 1, '5': 13, '10': 'acceptedPredictionTokens'},
    {'1': 'rejected_prediction_tokens', '3': 4, '4': 1, '5': 13, '10': 'rejectedPredictionTokens'},
  ],
};

@$core.Deprecated('Use chatCompletionDescriptor instead')
const ChatCompletion_Usage$json = {
  '1': 'Usage',
  '2': [
    {'1': 'prompt_tokens', '3': 1, '4': 1, '5': 13, '10': 'promptTokens'},
    {'1': 'completion_tokens', '3': 2, '4': 1, '5': 13, '10': 'completionTokens'},
    {'1': 'total_tokens', '3': 3, '4': 1, '5': 13, '10': 'totalTokens'},
    {'1': 'prompt_tokens_details', '3': 4, '4': 1, '5': 11, '6': '.ChatCompletion.Prompt_tokens_details', '10': 'promptTokensDetails'},
    {'1': 'completion_tokens_details', '3': 5, '4': 1, '5': 11, '6': '.ChatCompletion.Completion_tokens_details', '10': 'completionTokensDetails'},
  ],
};

/// Descriptor for `ChatCompletion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatCompletionDescriptor = $convert.base64Decode(
    'Cg5DaGF0Q29tcGxldGlvbhIOCgJpZBgBIAEoCVICaWQSFgoGb2JqZWN0GAIgASgJUgZvYmplY3'
    'QSGAoHY3JlYXRlZBgDIAEoDVIHY3JlYXRlZBIUCgVtb2RlbBgEIAEoCVIFbW9kZWwSMQoHY2hv'
    'aWNlcxgFIAMoCzIXLkNoYXRDb21wbGV0aW9uLkNob2ljZXNSB2Nob2ljZXMSKwoFdXNhZ2UYBi'
    'ABKAsyFS5DaGF0Q29tcGxldGlvbi5Vc2FnZVIFdXNhZ2USIQoMc2VydmljZV90aWVyGAcgASgJ'
    'UgtzZXJ2aWNlVGllchItChJzeXN0ZW1fZmluZ2VycHJpbnQYCCABKAlSEXN5c3RlbUZpbmdlcn'
    'ByaW50GlEKB01lc3NhZ2USEgoEcm9sZRgBIAEoCVIEcm9sZRIYCgdjb250ZW50GAIgASgJUgdj'
    'b250ZW50EhgKB3JlZnVzYWwYAyABKAlSB3JlZnVzYWwadwoHQ2hvaWNlcxIUCgVpbmRleBgBIA'
    'EoDVIFaW5kZXgSMQoHbWVzc2FnZRgCIAEoCzIXLkNoYXRDb21wbGV0aW9uLk1lc3NhZ2VSB21l'
    'c3NhZ2USIwoNZmluaXNoX3JlYXNvbhgDIAEoCVIMZmluaXNoUmVhc29uGl8KFVByb21wdF90b2'
    'tlbnNfZGV0YWlscxIjCg1jYWNoZWRfdG9rZW5zGAEgASgNUgxjYWNoZWRUb2tlbnMSIQoMYXVk'
    'aW9fdG9rZW5zGAIgASgNUgthdWRpb1Rva2VucxrlAQoZQ29tcGxldGlvbl90b2tlbnNfZGV0YW'
    'lscxIpChByZWFzb25pbmdfdG9rZW5zGAEgASgNUg9yZWFzb25pbmdUb2tlbnMSIQoMYXVkaW9f'
    'dG9rZW5zGAIgASgNUgthdWRpb1Rva2VucxI8ChphY2NlcHRlZF9wcmVkaWN0aW9uX3Rva2Vucx'
    'gDIAEoDVIYYWNjZXB0ZWRQcmVkaWN0aW9uVG9rZW5zEjwKGnJlamVjdGVkX3ByZWRpY3Rpb25f'
    'dG9rZW5zGAQgASgNUhhyZWplY3RlZFByZWRpY3Rpb25Ub2tlbnMavgIKBVVzYWdlEiMKDXByb2'
    '1wdF90b2tlbnMYASABKA1SDHByb21wdFRva2VucxIrChFjb21wbGV0aW9uX3Rva2VucxgCIAEo'
    'DVIQY29tcGxldGlvblRva2VucxIhCgx0b3RhbF90b2tlbnMYAyABKA1SC3RvdGFsVG9rZW5zEl'
    'kKFXByb21wdF90b2tlbnNfZGV0YWlscxgEIAEoCzIlLkNoYXRDb21wbGV0aW9uLlByb21wdF90'
    'b2tlbnNfZGV0YWlsc1ITcHJvbXB0VG9rZW5zRGV0YWlscxJlChljb21wbGV0aW9uX3Rva2Vuc1'
    '9kZXRhaWxzGAUgASgLMikuQ2hhdENvbXBsZXRpb24uQ29tcGxldGlvbl90b2tlbnNfZGV0YWls'
    'c1IXY29tcGxldGlvblRva2Vuc0RldGFpbHM=');

@$core.Deprecated('Use chatCompletionChunkDescriptor instead')
const ChatCompletionChunk$json = {
  '1': 'ChatCompletionChunk',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'object', '3': 2, '4': 1, '5': 9, '10': 'object'},
    {'1': 'created', '3': 3, '4': 1, '5': 13, '10': 'created'},
    {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    {'1': 'choices', '3': 5, '4': 3, '5': 11, '6': '.ChatCompletionChunk.Choices', '10': 'choices'},
    {'1': 'usage', '3': 6, '4': 1, '5': 11, '6': '.ChatCompletion.Usage', '10': 'usage'},
    {'1': 'service_tier', '3': 7, '4': 1, '5': 9, '10': 'serviceTier'},
    {'1': 'system_fingerprint', '3': 8, '4': 1, '5': 9, '10': 'systemFingerprint'},
  ],
  '3': [ChatCompletionChunk_Choices$json],
};

@$core.Deprecated('Use chatCompletionChunkDescriptor instead')
const ChatCompletionChunk_Choices$json = {
  '1': 'Choices',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 13, '10': 'index'},
    {'1': 'delta', '3': 2, '4': 1, '5': 11, '6': '.ChatCompletion.Message', '10': 'delta'},
    {'1': 'finish_reason', '3': 3, '4': 1, '5': 9, '10': 'finishReason'},
  ],
};

/// Descriptor for `ChatCompletionChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatCompletionChunkDescriptor = $convert.base64Decode(
    'ChNDaGF0Q29tcGxldGlvbkNodW5rEg4KAmlkGAEgASgJUgJpZBIWCgZvYmplY3QYAiABKAlSBm'
    '9iamVjdBIYCgdjcmVhdGVkGAMgASgNUgdjcmVhdGVkEhQKBW1vZGVsGAQgASgJUgVtb2RlbBI2'
    'CgdjaG9pY2VzGAUgAygLMhwuQ2hhdENvbXBsZXRpb25DaHVuay5DaG9pY2VzUgdjaG9pY2VzEi'
    'sKBXVzYWdlGAYgASgLMhUuQ2hhdENvbXBsZXRpb24uVXNhZ2VSBXVzYWdlEiEKDHNlcnZpY2Vf'
    'dGllchgHIAEoCVILc2VydmljZVRpZXISLQoSc3lzdGVtX2ZpbmdlcnByaW50GAggASgJUhFzeX'
    'N0ZW1GaW5nZXJwcmludBpzCgdDaG9pY2VzEhQKBWluZGV4GAEgASgNUgVpbmRleBItCgVkZWx0'
    'YRgCIAEoCzIXLkNoYXRDb21wbGV0aW9uLk1lc3NhZ2VSBWRlbHRhEiMKDWZpbmlzaF9yZWFzb2'
    '4YAyABKAlSDGZpbmlzaFJlYXNvbg==');

