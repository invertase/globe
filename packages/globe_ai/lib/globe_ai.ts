import { createOpenAI, OpenAIProvider } from "@ai-sdk/openai";
import openai from "./src/typescript/openai";
import google from "./src/typescript/google";

import {
  createGoogleGenerativeAI,
  GoogleGenerativeAIProvider,
} from "@ai-sdk/google";

export type GlobeAISdkState = {
  openAI?: OpenAIProvider;
  google?: GoogleGenerativeAIProvider;
};

type AiProvider = "openai" | "google_gen_ai";

export default {
  init: (provider: AiProvider, apiKey: string): GlobeAISdkState => {
    if (provider === "google_gen_ai") {
      const google = createGoogleGenerativeAI({
        apiKey,
      });
      return { google };
    }

    if (provider === "openai") {
      const openAI = createOpenAI({
        apiKey,
        compatibility: "strict",
      });
      return { openAI };
    }

    return {};
  },
  functions: {
    ...openai,
    ...google,
  },
};
