import { JSONSchemaToZod } from "@dmitryrechkin/json-schema-to-zod";

import { generateText, generateObject, streamText, streamObject } from "ai";
import { createOpenAI, OpenAIProvider } from "@ai-sdk/openai";

type GlobeAISdkState = {
  openAI: OpenAIProvider;
};

const openai_chat_generate_text = async (
  state: GlobeAISdkState,
  model_args: Uint8Array,
  model: string,
  prompt: string,
  system: string | undefined,
  callbackId: number
) => {
  const modelArgs = JsonPayload.decode(model_args);
  const { text } = await generateText({
    model: state.openAI.chat(model, { ...modelArgs }),
    prompt,
    system,
  });

  const result = new TextEncoder().encode(text);
  Dart.send_value(callbackId, result);
};

const openai_chat_stream_text = async (
  state: GlobeAISdkState,
  model: string,
  prompt: string,
  callbackId: number
) => {
  const result = streamText({
    model: state.openAI.responses(model),
    prompt,
  });

  for await (const part of result.fullStream) {
    if (part.type === "reasoning" || part.type === "text-delta") {
      const encoded = new TextEncoder().encode(part.textDelta);
      Dart.stream_value(callbackId, encoded);
    }
  }

  Dart.stream_value_end(callbackId);
};

const openai_chat_generate_object = async (
  state: GlobeAISdkState,
  model: string,
  prompt: string,
  schema: Uint8Array,
  callbackId: number
) => {
  const schemaJson = schema && JsonPayload.decode(schema);
  const zodSchema = JSONSchemaToZod.convert(schemaJson as any);

  const result = await generateObject({
    model: state.openAI.responses(model),
    schema: zodSchema,
    prompt,
  });

  const encoded = JsonPayload.encode(result.object);
  if (!encoded) {
    Dart.send_error(callbackId, "Failed to encode object");
    return;
  }

  Dart.send_value(callbackId, encoded);
};

const openai_chat_stream_object = async (
  state: GlobeAISdkState,
  model: string,
  prompt: string,
  schema: Uint8Array,
  callbackId: number
) => {
  const schemaJson = schema && JsonPayload.decode(schema);
  const zodSchema = JSONSchemaToZod.convert(schemaJson as any);

  const { fullStream } = await streamObject({
    model: state.openAI.responses(model),
    schema: zodSchema,
    prompt,
  });

  for await (const part of fullStream) {
    if (part.type != "object") continue;

    const encoded = JsonPayload.encode(part.object);
    if (!encoded) {
      Dart.send_error(callbackId, "Failed to encode object");
      return;
    }

    Dart.stream_value(callbackId, encoded);
  }

  Dart.stream_value_end(callbackId);
};

export default {
  init: (apiKey: string): GlobeAISdkState => {
    const openAI = createOpenAI({
      apiKey,
      compatibility: "strict",
    });

    return { openAI };
  },
  functions: {
    openai_chat_generate_text,
    openai_chat_generate_object,
    openai_chat_stream_text,
    openai_chat_stream_object,
  },
};
