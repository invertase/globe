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

class FileInput extends $pb.GeneratedMessage {
  factory FileInput({
    $core.String? name,
    $core.String? mimeType,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (mimeType != null) {
      $result.mimeType = mimeType;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  FileInput._() : super();
  factory FileInput.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FileInput.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileInput',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'mimeType')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FileInput clone() => FileInput()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FileInput copyWith(void Function(FileInput) updates) =>
      super.copyWith((message) => updates(message as FileInput)) as FileInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileInput create() => FileInput._();
  FileInput createEmptyInstance() => create();
  static $pb.PbList<FileInput> createRepeated() => $pb.PbList<FileInput>();
  @$core.pragma('dart2js:noInline')
  static FileInput getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileInput>(create);
  static FileInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mimeType => $_getSZ(1);
  @$pb.TagNumber(2)
  set mimeType($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMimeType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMimeType() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}

class TextInput extends $pb.GeneratedMessage {
  factory TextInput({
    $core.String? text,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    return $result;
  }
  TextInput._() : super();
  factory TextInput.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TextInput.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextInput',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TextInput clone() => TextInput()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TextInput copyWith(void Function(TextInput) updates) =>
      super.copyWith((message) => updates(message as TextInput)) as TextInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TextInput create() => TextInput._();
  TextInput createEmptyInstance() => create();
  static $pb.PbList<TextInput> createRepeated() => $pb.PbList<TextInput>();
  @$core.pragma('dart2js:noInline')
  static TextInput getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextInput>(create);
  static TextInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class OpenAIMessage extends $pb.GeneratedMessage {
  factory OpenAIMessage({
    $core.String? role,
    $core.Iterable<OpenAIInput>? content,
  }) {
    final $result = create();
    if (role != null) {
      $result.role = role;
    }
    if (content != null) {
      $result.content.addAll(content);
    }
    return $result;
  }
  OpenAIMessage._() : super();
  factory OpenAIMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OpenAIMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenAIMessage',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..pc<OpenAIInput>(2, _omitFieldNames ? '' : 'content', $pb.PbFieldType.PM,
        subBuilder: OpenAIInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OpenAIMessage clone() => OpenAIMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OpenAIMessage copyWith(void Function(OpenAIMessage) updates) =>
      super.copyWith((message) => updates(message as OpenAIMessage))
          as OpenAIMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenAIMessage create() => OpenAIMessage._();
  OpenAIMessage createEmptyInstance() => create();
  static $pb.PbList<OpenAIMessage> createRepeated() =>
      $pb.PbList<OpenAIMessage>();
  @$core.pragma('dart2js:noInline')
  static OpenAIMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenAIMessage>(create);
  static OpenAIMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<OpenAIInput> get content => $_getList(1);
}

class OpenAIMessages extends $pb.GeneratedMessage {
  factory OpenAIMessages({
    $core.Iterable<OpenAIMessage>? messages,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    return $result;
  }
  OpenAIMessages._() : super();
  factory OpenAIMessages.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OpenAIMessages.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenAIMessages',
      createEmptyInstance: create)
    ..pc<OpenAIMessage>(
        1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM,
        subBuilder: OpenAIMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OpenAIMessages clone() => OpenAIMessages()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OpenAIMessages copyWith(void Function(OpenAIMessages) updates) =>
      super.copyWith((message) => updates(message as OpenAIMessages))
          as OpenAIMessages;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenAIMessages create() => OpenAIMessages._();
  OpenAIMessages createEmptyInstance() => create();
  static $pb.PbList<OpenAIMessages> createRepeated() =>
      $pb.PbList<OpenAIMessages>();
  @$core.pragma('dart2js:noInline')
  static OpenAIMessages getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenAIMessages>(create);
  static OpenAIMessages? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OpenAIMessage> get messages => $_getList(0);
}

enum OpenAIInput_Input { text, file, notSet }

class OpenAIInput extends $pb.GeneratedMessage {
  factory OpenAIInput({
    $core.String? text,
    FileInput? file,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    if (file != null) {
      $result.file = file;
    }
    return $result;
  }
  OpenAIInput._() : super();
  factory OpenAIInput.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OpenAIInput.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OpenAIInput_Input> _OpenAIInput_InputByTag =
      {
    1: OpenAIInput_Input.text,
    2: OpenAIInput_Input.file,
    0: OpenAIInput_Input.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpenAIInput',
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOM<FileInput>(2, _omitFieldNames ? '' : 'file',
        subBuilder: FileInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OpenAIInput clone() => OpenAIInput()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OpenAIInput copyWith(void Function(OpenAIInput) updates) =>
      super.copyWith((message) => updates(message as OpenAIInput))
          as OpenAIInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenAIInput create() => OpenAIInput._();
  OpenAIInput createEmptyInstance() => create();
  static $pb.PbList<OpenAIInput> createRepeated() => $pb.PbList<OpenAIInput>();
  @$core.pragma('dart2js:noInline')
  static OpenAIInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OpenAIInput>(create);
  static OpenAIInput? _defaultInstance;

  OpenAIInput_Input whichInput() => _OpenAIInput_InputByTag[$_whichOneof(0)]!;
  void clearInput() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  FileInput get file => $_getN(1);
  @$pb.TagNumber(2)
  set file(FileInput v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearFile() => clearField(2);
  @$pb.TagNumber(2)
  FileInput ensureFile() => $_ensure(1);
}

enum EitherMessagesOrPrompt_Input { prompt, messages, notSet }

class EitherMessagesOrPrompt extends $pb.GeneratedMessage {
  factory EitherMessagesOrPrompt({
    $core.String? prompt,
    OpenAIMessages? messages,
  }) {
    final $result = create();
    if (prompt != null) {
      $result.prompt = prompt;
    }
    if (messages != null) {
      $result.messages = messages;
    }
    return $result;
  }
  EitherMessagesOrPrompt._() : super();
  factory EitherMessagesOrPrompt.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EitherMessagesOrPrompt.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, EitherMessagesOrPrompt_Input>
      _EitherMessagesOrPrompt_InputByTag = {
    1: EitherMessagesOrPrompt_Input.prompt,
    2: EitherMessagesOrPrompt_Input.messages,
    0: EitherMessagesOrPrompt_Input.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EitherMessagesOrPrompt',
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'prompt')
    ..aOM<OpenAIMessages>(2, _omitFieldNames ? '' : 'messages',
        subBuilder: OpenAIMessages.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EitherMessagesOrPrompt clone() =>
      EitherMessagesOrPrompt()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EitherMessagesOrPrompt copyWith(
          void Function(EitherMessagesOrPrompt) updates) =>
      super.copyWith((message) => updates(message as EitherMessagesOrPrompt))
          as EitherMessagesOrPrompt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EitherMessagesOrPrompt create() => EitherMessagesOrPrompt._();
  EitherMessagesOrPrompt createEmptyInstance() => create();
  static $pb.PbList<EitherMessagesOrPrompt> createRepeated() =>
      $pb.PbList<EitherMessagesOrPrompt>();
  @$core.pragma('dart2js:noInline')
  static EitherMessagesOrPrompt getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EitherMessagesOrPrompt>(create);
  static EitherMessagesOrPrompt? _defaultInstance;

  EitherMessagesOrPrompt_Input whichInput() =>
      _EitherMessagesOrPrompt_InputByTag[$_whichOneof(0)]!;
  void clearInput() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get prompt => $_getSZ(0);
  @$pb.TagNumber(1)
  set prompt($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPrompt() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrompt() => clearField(1);

  @$pb.TagNumber(2)
  OpenAIMessages get messages => $_getN(1);
  @$pb.TagNumber(2)
  set messages(OpenAIMessages v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessages() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessages() => clearField(2);
  @$pb.TagNumber(2)
  OpenAIMessages ensureMessages() => $_ensure(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
