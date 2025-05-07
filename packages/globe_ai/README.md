# 🧠 globe_ai

`globe_ai` is a Dart-first package for interacting with large language models (LLMs) like OpenAI’s GPT series — built specifically for the Globe runtime.

> This package currently only works in **Globe** Platform. Support for using it outside of **Globe** is coming soon. Internally, this package wraps the [AI-SDK OpenAI](https://ai-sdk.dev/providers/ai-sdk-providers/openai) to handle model execution and output parsing.

## ✨ Features

- 📝 `generateText` — basic prompt-response text generation

- 📡 `streamText` — stream text responses as they’re generated

- 🧱 `generateObject` — validate structured JSON output against a schema

- 🌊 `streamObject` — stream and validate structured data

## 🚀 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  globe_ai: ^<latest-version>
```

### Setup

Configure your model provider (e.g. OpenAI):

```dart
final model = openai.chat('gpt-4o', user: 'Chima');
```

or

```dart
final model = openai('gpt-4o');
```

## Usage

### 🔹 Text Generation

```dart
final result = await generateText(
  model: openai.chat('gpt-4o'),
  prompt: 'What is the capital of Ghana?',
);
print(result);
```

### 🔹 Streaming Text

```dart
final stream = streamText(
  model: openai('o4-mini'),
  prompt: 'Describe the Mission burrito vs SF burrito debate.',
);

await for (final chunk in stream) {
  stdout.write(chunk);
}
```

### 🔹 Structured Object Generation

```dart
final schema = l.schema({
  'recipe': l.schema({
    'name': l.string(),
    'ingredients': l.list(validators: [
      l.schema({'name': l.string(), 'amount': l.string()}),
    ]),
    'steps': l.list(validators: [l.string()]),
  })
});

final result = await generateObject<Map<String, dynamic>>(
  model: openai('gpt-4.1'),
  prompt: 'Generate a lasagna recipe.',
  schema: schema,
);

print(result['recipe']['name']);
```

### 🔹 Streaming Structured Objects

```dart
final resultStream = streamObject<Map<String, dynamic>>(
  model: openai('gpt-4.1'),
  prompt: 'Generate a lasagna recipe.',
  schema: schema,
);

await for (final chunk in resultStream) {
  print(chunk); // Validated partial output
}
```

## 📚 Roadmap

- 🌐 Outside-Globe support — Coming soon

- 🤖 Additional model providers — In progress

- 🧪 Unit tests & CI examples

- 📖 Function-level API docs

## 🛠️ Development

- Building the JS package

  ```sh
  dart pub run rps build
  ```

- Generate types from protos

  ```sh
  dart pub run rps gen_dart
  ```

  and

  ```sh
  dart pub run rps gen_typescript
  ```
