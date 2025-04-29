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

class ChatCompletion_Message extends $pb.GeneratedMessage {
  factory ChatCompletion_Message({
    $core.String? role,
    $core.String? content,
    $core.String? refusal,
  }) {
    final $result = create();
    if (role != null) {
      $result.role = role;
    }
    if (content != null) {
      $result.content = content;
    }
    if (refusal != null) {
      $result.refusal = refusal;
    }
    return $result;
  }
  ChatCompletion_Message._() : super();
  factory ChatCompletion_Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion_Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion.Message', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..aOS(3, _omitFieldNames ? '' : 'refusal')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion_Message clone() => ChatCompletion_Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion_Message copyWith(void Function(ChatCompletion_Message) updates) => super.copyWith((message) => updates(message as ChatCompletion_Message)) as ChatCompletion_Message;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Message create() => ChatCompletion_Message._();
  ChatCompletion_Message createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion_Message> createRepeated() => $pb.PbList<ChatCompletion_Message>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion_Message>(create);
  static ChatCompletion_Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refusal => $_getSZ(2);
  @$pb.TagNumber(3)
  set refusal($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefusal() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefusal() => clearField(3);
}

class ChatCompletion_Choices extends $pb.GeneratedMessage {
  factory ChatCompletion_Choices({
    $core.int? index,
    ChatCompletion_Message? message,
    $core.String? finishReason,
  }) {
    final $result = create();
    if (index != null) {
      $result.index = index;
    }
    if (message != null) {
      $result.message = message;
    }
    if (finishReason != null) {
      $result.finishReason = finishReason;
    }
    return $result;
  }
  ChatCompletion_Choices._() : super();
  factory ChatCompletion_Choices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion_Choices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion.Choices', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'index', $pb.PbFieldType.OU3)
    ..aOM<ChatCompletion_Message>(2, _omitFieldNames ? '' : 'message', subBuilder: ChatCompletion_Message.create)
    ..aOS(3, _omitFieldNames ? '' : 'finishReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion_Choices clone() => ChatCompletion_Choices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion_Choices copyWith(void Function(ChatCompletion_Choices) updates) => super.copyWith((message) => updates(message as ChatCompletion_Choices)) as ChatCompletion_Choices;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Choices create() => ChatCompletion_Choices._();
  ChatCompletion_Choices createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion_Choices> createRepeated() => $pb.PbList<ChatCompletion_Choices>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Choices getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion_Choices>(create);
  static ChatCompletion_Choices? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => clearField(1);

  @$pb.TagNumber(2)
  ChatCompletion_Message get message => $_getN(1);
  @$pb.TagNumber(2)
  set message(ChatCompletion_Message v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
  @$pb.TagNumber(2)
  ChatCompletion_Message ensureMessage() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get finishReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set finishReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinishReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinishReason() => clearField(3);
}

class ChatCompletion_Prompt_tokens_details extends $pb.GeneratedMessage {
  factory ChatCompletion_Prompt_tokens_details({
    $core.int? cachedTokens,
    $core.int? audioTokens,
  }) {
    final $result = create();
    if (cachedTokens != null) {
      $result.cachedTokens = cachedTokens;
    }
    if (audioTokens != null) {
      $result.audioTokens = audioTokens;
    }
    return $result;
  }
  ChatCompletion_Prompt_tokens_details._() : super();
  factory ChatCompletion_Prompt_tokens_details.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion_Prompt_tokens_details.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion.Prompt_tokens_details', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'cachedTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'audioTokens', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion_Prompt_tokens_details clone() => ChatCompletion_Prompt_tokens_details()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion_Prompt_tokens_details copyWith(void Function(ChatCompletion_Prompt_tokens_details) updates) => super.copyWith((message) => updates(message as ChatCompletion_Prompt_tokens_details)) as ChatCompletion_Prompt_tokens_details;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Prompt_tokens_details create() => ChatCompletion_Prompt_tokens_details._();
  ChatCompletion_Prompt_tokens_details createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion_Prompt_tokens_details> createRepeated() => $pb.PbList<ChatCompletion_Prompt_tokens_details>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Prompt_tokens_details getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion_Prompt_tokens_details>(create);
  static ChatCompletion_Prompt_tokens_details? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get cachedTokens => $_getIZ(0);
  @$pb.TagNumber(1)
  set cachedTokens($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCachedTokens() => $_has(0);
  @$pb.TagNumber(1)
  void clearCachedTokens() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get audioTokens => $_getIZ(1);
  @$pb.TagNumber(2)
  set audioTokens($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAudioTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioTokens() => clearField(2);
}

class ChatCompletion_Completion_tokens_details extends $pb.GeneratedMessage {
  factory ChatCompletion_Completion_tokens_details({
    $core.int? reasoningTokens,
    $core.int? audioTokens,
    $core.int? acceptedPredictionTokens,
    $core.int? rejectedPredictionTokens,
  }) {
    final $result = create();
    if (reasoningTokens != null) {
      $result.reasoningTokens = reasoningTokens;
    }
    if (audioTokens != null) {
      $result.audioTokens = audioTokens;
    }
    if (acceptedPredictionTokens != null) {
      $result.acceptedPredictionTokens = acceptedPredictionTokens;
    }
    if (rejectedPredictionTokens != null) {
      $result.rejectedPredictionTokens = rejectedPredictionTokens;
    }
    return $result;
  }
  ChatCompletion_Completion_tokens_details._() : super();
  factory ChatCompletion_Completion_tokens_details.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion_Completion_tokens_details.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion.Completion_tokens_details', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'reasoningTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'audioTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'acceptedPredictionTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rejectedPredictionTokens', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion_Completion_tokens_details clone() => ChatCompletion_Completion_tokens_details()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion_Completion_tokens_details copyWith(void Function(ChatCompletion_Completion_tokens_details) updates) => super.copyWith((message) => updates(message as ChatCompletion_Completion_tokens_details)) as ChatCompletion_Completion_tokens_details;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Completion_tokens_details create() => ChatCompletion_Completion_tokens_details._();
  ChatCompletion_Completion_tokens_details createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion_Completion_tokens_details> createRepeated() => $pb.PbList<ChatCompletion_Completion_tokens_details>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Completion_tokens_details getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion_Completion_tokens_details>(create);
  static ChatCompletion_Completion_tokens_details? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get reasoningTokens => $_getIZ(0);
  @$pb.TagNumber(1)
  set reasoningTokens($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReasoningTokens() => $_has(0);
  @$pb.TagNumber(1)
  void clearReasoningTokens() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get audioTokens => $_getIZ(1);
  @$pb.TagNumber(2)
  set audioTokens($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAudioTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioTokens() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get acceptedPredictionTokens => $_getIZ(2);
  @$pb.TagNumber(3)
  set acceptedPredictionTokens($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAcceptedPredictionTokens() => $_has(2);
  @$pb.TagNumber(3)
  void clearAcceptedPredictionTokens() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get rejectedPredictionTokens => $_getIZ(3);
  @$pb.TagNumber(4)
  set rejectedPredictionTokens($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRejectedPredictionTokens() => $_has(3);
  @$pb.TagNumber(4)
  void clearRejectedPredictionTokens() => clearField(4);
}

class ChatCompletion_Usage extends $pb.GeneratedMessage {
  factory ChatCompletion_Usage({
    $core.int? promptTokens,
    $core.int? completionTokens,
    $core.int? totalTokens,
    ChatCompletion_Prompt_tokens_details? promptTokensDetails,
    ChatCompletion_Completion_tokens_details? completionTokensDetails,
  }) {
    final $result = create();
    if (promptTokens != null) {
      $result.promptTokens = promptTokens;
    }
    if (completionTokens != null) {
      $result.completionTokens = completionTokens;
    }
    if (totalTokens != null) {
      $result.totalTokens = totalTokens;
    }
    if (promptTokensDetails != null) {
      $result.promptTokensDetails = promptTokensDetails;
    }
    if (completionTokensDetails != null) {
      $result.completionTokensDetails = completionTokensDetails;
    }
    return $result;
  }
  ChatCompletion_Usage._() : super();
  factory ChatCompletion_Usage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion_Usage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion.Usage', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'promptTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'completionTokens', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalTokens', $pb.PbFieldType.OU3)
    ..aOM<ChatCompletion_Prompt_tokens_details>(4, _omitFieldNames ? '' : 'promptTokensDetails', subBuilder: ChatCompletion_Prompt_tokens_details.create)
    ..aOM<ChatCompletion_Completion_tokens_details>(5, _omitFieldNames ? '' : 'completionTokensDetails', subBuilder: ChatCompletion_Completion_tokens_details.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion_Usage clone() => ChatCompletion_Usage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion_Usage copyWith(void Function(ChatCompletion_Usage) updates) => super.copyWith((message) => updates(message as ChatCompletion_Usage)) as ChatCompletion_Usage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Usage create() => ChatCompletion_Usage._();
  ChatCompletion_Usage createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion_Usage> createRepeated() => $pb.PbList<ChatCompletion_Usage>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion_Usage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion_Usage>(create);
  static ChatCompletion_Usage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get promptTokens => $_getIZ(0);
  @$pb.TagNumber(1)
  set promptTokens($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPromptTokens() => $_has(0);
  @$pb.TagNumber(1)
  void clearPromptTokens() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get completionTokens => $_getIZ(1);
  @$pb.TagNumber(2)
  set completionTokens($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCompletionTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompletionTokens() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalTokens => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalTokens($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalTokens() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalTokens() => clearField(3);

  @$pb.TagNumber(4)
  ChatCompletion_Prompt_tokens_details get promptTokensDetails => $_getN(3);
  @$pb.TagNumber(4)
  set promptTokensDetails(ChatCompletion_Prompt_tokens_details v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPromptTokensDetails() => $_has(3);
  @$pb.TagNumber(4)
  void clearPromptTokensDetails() => clearField(4);
  @$pb.TagNumber(4)
  ChatCompletion_Prompt_tokens_details ensurePromptTokensDetails() => $_ensure(3);

  @$pb.TagNumber(5)
  ChatCompletion_Completion_tokens_details get completionTokensDetails => $_getN(4);
  @$pb.TagNumber(5)
  set completionTokensDetails(ChatCompletion_Completion_tokens_details v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCompletionTokensDetails() => $_has(4);
  @$pb.TagNumber(5)
  void clearCompletionTokensDetails() => clearField(5);
  @$pb.TagNumber(5)
  ChatCompletion_Completion_tokens_details ensureCompletionTokensDetails() => $_ensure(4);
}

class ChatCompletion extends $pb.GeneratedMessage {
  factory ChatCompletion({
    $core.String? id,
    $core.String? object,
    $core.int? created,
    $core.String? model,
    $core.Iterable<ChatCompletion_Choices>? choices,
    ChatCompletion_Usage? usage,
    $core.String? serviceTier,
    $core.String? systemFingerprint,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (object != null) {
      $result.object = object;
    }
    if (created != null) {
      $result.created = created;
    }
    if (model != null) {
      $result.model = model;
    }
    if (choices != null) {
      $result.choices.addAll(choices);
    }
    if (usage != null) {
      $result.usage = usage;
    }
    if (serviceTier != null) {
      $result.serviceTier = serviceTier;
    }
    if (systemFingerprint != null) {
      $result.systemFingerprint = systemFingerprint;
    }
    return $result;
  }
  ChatCompletion._() : super();
  factory ChatCompletion.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletion.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletion', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'object')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'created', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'model')
    ..pc<ChatCompletion_Choices>(5, _omitFieldNames ? '' : 'choices', $pb.PbFieldType.PM, subBuilder: ChatCompletion_Choices.create)
    ..aOM<ChatCompletion_Usage>(6, _omitFieldNames ? '' : 'usage', subBuilder: ChatCompletion_Usage.create)
    ..aOS(7, _omitFieldNames ? '' : 'serviceTier')
    ..aOS(8, _omitFieldNames ? '' : 'systemFingerprint')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletion clone() => ChatCompletion()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletion copyWith(void Function(ChatCompletion) updates) => super.copyWith((message) => updates(message as ChatCompletion)) as ChatCompletion;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletion create() => ChatCompletion._();
  ChatCompletion createEmptyInstance() => create();
  static $pb.PbList<ChatCompletion> createRepeated() => $pb.PbList<ChatCompletion>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletion>(create);
  static ChatCompletion? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get object => $_getSZ(1);
  @$pb.TagNumber(2)
  set object($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasObject() => $_has(1);
  @$pb.TagNumber(2)
  void clearObject() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get created => $_getIZ(2);
  @$pb.TagNumber(3)
  set created($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreated() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get model => $_getSZ(3);
  @$pb.TagNumber(4)
  set model($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<ChatCompletion_Choices> get choices => $_getList(4);

  @$pb.TagNumber(6)
  ChatCompletion_Usage get usage => $_getN(5);
  @$pb.TagNumber(6)
  set usage(ChatCompletion_Usage v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUsage() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsage() => clearField(6);
  @$pb.TagNumber(6)
  ChatCompletion_Usage ensureUsage() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get serviceTier => $_getSZ(6);
  @$pb.TagNumber(7)
  set serviceTier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasServiceTier() => $_has(6);
  @$pb.TagNumber(7)
  void clearServiceTier() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get systemFingerprint => $_getSZ(7);
  @$pb.TagNumber(8)
  set systemFingerprint($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSystemFingerprint() => $_has(7);
  @$pb.TagNumber(8)
  void clearSystemFingerprint() => clearField(8);
}

class ChatCompletionChunk_Choices extends $pb.GeneratedMessage {
  factory ChatCompletionChunk_Choices({
    $core.int? index,
    ChatCompletion_Message? delta,
    $core.String? finishReason,
  }) {
    final $result = create();
    if (index != null) {
      $result.index = index;
    }
    if (delta != null) {
      $result.delta = delta;
    }
    if (finishReason != null) {
      $result.finishReason = finishReason;
    }
    return $result;
  }
  ChatCompletionChunk_Choices._() : super();
  factory ChatCompletionChunk_Choices.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletionChunk_Choices.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletionChunk.Choices', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'index', $pb.PbFieldType.OU3)
    ..aOM<ChatCompletion_Message>(2, _omitFieldNames ? '' : 'delta', subBuilder: ChatCompletion_Message.create)
    ..aOS(3, _omitFieldNames ? '' : 'finishReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletionChunk_Choices clone() => ChatCompletionChunk_Choices()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletionChunk_Choices copyWith(void Function(ChatCompletionChunk_Choices) updates) => super.copyWith((message) => updates(message as ChatCompletionChunk_Choices)) as ChatCompletionChunk_Choices;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletionChunk_Choices create() => ChatCompletionChunk_Choices._();
  ChatCompletionChunk_Choices createEmptyInstance() => create();
  static $pb.PbList<ChatCompletionChunk_Choices> createRepeated() => $pb.PbList<ChatCompletionChunk_Choices>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletionChunk_Choices getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletionChunk_Choices>(create);
  static ChatCompletionChunk_Choices? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => clearField(1);

  @$pb.TagNumber(2)
  ChatCompletion_Message get delta => $_getN(1);
  @$pb.TagNumber(2)
  set delta(ChatCompletion_Message v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDelta() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelta() => clearField(2);
  @$pb.TagNumber(2)
  ChatCompletion_Message ensureDelta() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get finishReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set finishReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinishReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinishReason() => clearField(3);
}

class ChatCompletionChunk extends $pb.GeneratedMessage {
  factory ChatCompletionChunk({
    $core.String? id,
    $core.String? object,
    $core.int? created,
    $core.String? model,
    $core.Iterable<ChatCompletionChunk_Choices>? choices,
    ChatCompletion_Usage? usage,
    $core.String? serviceTier,
    $core.String? systemFingerprint,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (object != null) {
      $result.object = object;
    }
    if (created != null) {
      $result.created = created;
    }
    if (model != null) {
      $result.model = model;
    }
    if (choices != null) {
      $result.choices.addAll(choices);
    }
    if (usage != null) {
      $result.usage = usage;
    }
    if (serviceTier != null) {
      $result.serviceTier = serviceTier;
    }
    if (systemFingerprint != null) {
      $result.systemFingerprint = systemFingerprint;
    }
    return $result;
  }
  ChatCompletionChunk._() : super();
  factory ChatCompletionChunk.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatCompletionChunk.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatCompletionChunk', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'object')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'created', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'model')
    ..pc<ChatCompletionChunk_Choices>(5, _omitFieldNames ? '' : 'choices', $pb.PbFieldType.PM, subBuilder: ChatCompletionChunk_Choices.create)
    ..aOM<ChatCompletion_Usage>(6, _omitFieldNames ? '' : 'usage', subBuilder: ChatCompletion_Usage.create)
    ..aOS(7, _omitFieldNames ? '' : 'serviceTier')
    ..aOS(8, _omitFieldNames ? '' : 'systemFingerprint')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatCompletionChunk clone() => ChatCompletionChunk()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatCompletionChunk copyWith(void Function(ChatCompletionChunk) updates) => super.copyWith((message) => updates(message as ChatCompletionChunk)) as ChatCompletionChunk;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCompletionChunk create() => ChatCompletionChunk._();
  ChatCompletionChunk createEmptyInstance() => create();
  static $pb.PbList<ChatCompletionChunk> createRepeated() => $pb.PbList<ChatCompletionChunk>();
  @$core.pragma('dart2js:noInline')
  static ChatCompletionChunk getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCompletionChunk>(create);
  static ChatCompletionChunk? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get object => $_getSZ(1);
  @$pb.TagNumber(2)
  set object($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasObject() => $_has(1);
  @$pb.TagNumber(2)
  void clearObject() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get created => $_getIZ(2);
  @$pb.TagNumber(3)
  set created($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreated() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get model => $_getSZ(3);
  @$pb.TagNumber(4)
  set model($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<ChatCompletionChunk_Choices> get choices => $_getList(4);

  @$pb.TagNumber(6)
  ChatCompletion_Usage get usage => $_getN(5);
  @$pb.TagNumber(6)
  set usage(ChatCompletion_Usage v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUsage() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsage() => clearField(6);
  @$pb.TagNumber(6)
  ChatCompletion_Usage ensureUsage() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get serviceTier => $_getSZ(6);
  @$pb.TagNumber(7)
  set serviceTier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasServiceTier() => $_has(6);
  @$pb.TagNumber(7)
  void clearServiceTier() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get systemFingerprint => $_getSZ(7);
  @$pb.TagNumber(8)
  set systemFingerprint($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSystemFingerprint() => $_has(7);
  @$pb.TagNumber(8)
  void clearSystemFingerprint() => clearField(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
