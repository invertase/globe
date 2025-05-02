import { ChatCompletion, ChatCompletionChunk } from "./generated/openai";

import { generateText, LanguageModelV1, streamText } from "ai";
import { createOpenAI, OpenAIProvider } from "@ai-sdk/openai"; // Ensure OPENAI_API_KEY environment variable is set

type GlobeAISdkState = {
  openAI: OpenAIProvider;
};

const openai_chat_generate_text = async (
  state: GlobeAISdkState,
  model: string,
  prompt: string,
  system: string | undefined,
  callbackId: number
) => {
  const { text } = await generateText({
    model: state.openAI.chat(model),
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
  system: string | undefined,
  callbackId: number
) => {
  const result = await streamText({
    model: state.openAI.chat(model),
    prompt,
    system,
  });

  console.log("I am here");

  for await (const part of result.fullStream) {
    if (part.type === "reasoning") {
      console.log(`Reasoning: ${part.textDelta}`);
    } else if (part.type === "text-delta") {
      console.log(part.textDelta);
    }
  }

  Dart.stream_value_end(callbackId);
};

export default {
  init: (apiKey: string): GlobeAISdkState => {
    const openAI = createOpenAI({
      apiKey,
      compatibility: "strict", // strict mode, enable when using the OpenAI API
    });

    return { openAI };
  },
  functions: { openai_chat_generate_text, openai_chat_stream_text },
};
