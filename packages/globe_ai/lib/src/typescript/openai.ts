import { JSONObject, JSONSchemaToZod } from "@dmitryrechkin/json-schema-to-zod";
import { generateText, generateObject, streamText, streamObject } from "ai";

import { GlobeAISdkState } from "../../globe_ai";
import { EitherMessagesOrPrompt } from "../../generated/openai";

const openai_chat_generate_text = async (
  state: GlobeAISdkState,
  model_args: JSONObject,
  model: string,
  prompt: Uint8Array,
  callbackId: number
) => {
  const actualModel = state.openAI!.chat(model, { ...model_args });
  const eitherPromptOrMessage =
    EitherMessagesOrPrompt.deserializeBinary(prompt);

  let messages: any[] = [];

  if (eitherPromptOrMessage.has_messages) {
    messages = eitherPromptOrMessage.messages.messages.map((m) => ({
      role: m.role,
      content: m.content.map((d) => {
        if (d.has_file) {
          return {
            type: "file",
            data: d.file.data,
            filename: d.file.name,
            mimeType: d.file.mime_type,
          };
        }

        return { type: "text", text: d.text };
      }),
    }));
  }

  let pendingPromise =
    messages.length === 0
      ? generateText({
          model: actualModel,
          prompt: eitherPromptOrMessage.prompt,
        })
      : generateText({ model: actualModel, messages });

  const { text } = await pendingPromise;

  const result = new TextEncoder().encode(text);
  Dart.send_value(callbackId, result);
};

const openai_chat_stream_text = async (
  state: GlobeAISdkState,
  model: string,
  prompt: Uint8Array,
  callbackId: number
) => {
  const actualModel = state.openAI!.responses(model);
  const eitherPromptOrMessage =
    EitherMessagesOrPrompt.deserializeBinary(prompt);

  let messages: any[] = [];

  if (eitherPromptOrMessage.has_messages) {
    messages = eitherPromptOrMessage.messages.messages.map((m) => ({
      role: m.role,
      content: m.content.map((d) => {
        if (d.has_file) {
          return {
            type: "file",
            data: d.file.data,
            filename: d.file.name,
            mimeType: d.file.mime_type,
          };
        }

        return { type: "text", text: d.text };
      }),
    }));
  }

  let pendingPromise =
    messages.length === 0
      ? streamText({
          model: actualModel,
          prompt: eitherPromptOrMessage.prompt,
        })
      : streamText({ model: actualModel, messages });

  const result = await pendingPromise;

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
  schema: JSONObject,
  callbackId: number
) => {
  const zodSchema = JSONSchemaToZod.convert(schema);

  const result = await generateObject({
    model: state.openAI!.responses(model),
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
  schema: JSONObject,
  callbackId: number
) => {
  const zodSchema = JSONSchemaToZod.convert(schema);

  const { fullStream } = await streamObject({
    model: state.openAI!.responses(model),
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
  openai_chat_generate_text,
  openai_chat_stream_text,
  openai_chat_generate_object,
  openai_chat_stream_object,
};
