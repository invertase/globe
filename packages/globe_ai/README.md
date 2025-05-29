# 🧠 globe_ai

`globe_ai` is a Dart-first package for interacting with large language models (LLMs) like OpenAI’s GPT series.

## ✨ Features

- 📝 `generateText` — basic prompt or messages based text generation

- 📡 `streamText` — stream text responses as they’re generated

- 🧱 `generateObject` — validate structured JSON output against a schema

- 🌊 `streamObject` — stream and validate structured data

## 🚀 Installation

### Install Globe Runtime

You can install globe runtime using either of these approaches.

- Using `Globe CLI`.

  If you have Globe CLI installed locally, you can run `globe runtime install`.

- Adding Manually to your Environment

  Download the `libglobe_runtime` dynamic library for your Platform from [Github Release Pages](https://github.com/invertase/globe_runtime/releases) and place it in `~/.globe/runtime/` directory.

### Setup

- Add dependency

```yaml
dependencies:
  globe_ai: ^<latest-version>
```

- Configure your model provider (e.g. OpenAI):

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

or

```dart
final textWithPdf = await generateText(
  model: openai.chat('gpt-4o', user: 'Chima'),
  messages: [
    OpenAIMessage(
      role: 'user',
      content: [
        OpenAIContent.text( 'What is the title of this book?'),
        OpenAIContent.file(
          File('bin/test_doc.pdf'),
          mimeType: 'application/pdf',
        ),
      ],
    ),
  ],
);
print(textWithPdf);
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
