import { OpenAI } from "openai";
import { ChatCompletion, ChatCompletionChunk } from "./generated/openai";

type GlobeAISdkState = {
  openAI: OpenAI;
};

const openai_chat_complete = async (
  state: GlobeAISdkState,
  model: string,
  query: string,
  callbackId: number
) => {
  const completion = await state.openAI.chat.completions.create({
    model,
    messages: [{ role: "user", content: query }],
  });

  const choices: ChatCompletion.Choices[] = completion.choices.map((choice) => {
    return new ChatCompletion.Choices({
      index: choice.index,
      finish_reason: choice.finish_reason,
      message: new ChatCompletion.Message({
        role: choice.message.role.toString(),
        content: choice.message.content?.toString(),
        refusal: choice.message.refusal?.toString(),
      }),
    });
  });

  const usage = new ChatCompletion.Usage({
    total_tokens: completion.usage?.total_tokens,
    completion_tokens: completion.usage?.completion_tokens,
    prompt_tokens: completion.usage?.prompt_tokens,
    prompt_tokens_details: new ChatCompletion.Prompt_tokens_details(
      completion.usage?.prompt_tokens_details
    ),
    completion_tokens_details: new ChatCompletion.Completion_tokens_details(
      completion.usage?.completion_tokens_details
    ),
  });

  const response = new ChatCompletion({
    id: completion.id,
    model: completion.model,
    created: completion.created,
    system_fingerprint: completion.system_fingerprint,
    object: completion.object,
    service_tier: completion.service_tier?.toString(),
    choices,
    usage,
  });

  Dart.send_value(callbackId, response.serializeBinary());
};

const openai_chat_complete_stream = async (
  state: GlobeAISdkState,
  model: string,
  query: string,
  callbackId: number
) => {
  const completion = await state.openAI.chat.completions.create({
    model,
    messages: [{ role: "user", content: query }],
    stream: true,
  });

  for await (const chunk of completion) {
    const choices: ChatCompletionChunk.Choices[] = chunk.choices.map(
      (choice) => {
        return new ChatCompletionChunk.Choices({
          index: choice.index,
          finish_reason: choice.finish_reason?.toString(),
          delta: new ChatCompletion.Message({
            role: choice.delta.role?.toString(),
            content: choice.delta.content?.toString(),
            refusal: choice.delta.refusal?.toString(),
          }),
        });
      }
    );

    const usage = new ChatCompletion.Usage({
      total_tokens: chunk.usage?.total_tokens,
      completion_tokens: chunk.usage?.completion_tokens,
      prompt_tokens: chunk.usage?.prompt_tokens,
      prompt_tokens_details: new ChatCompletion.Prompt_tokens_details(
        chunk.usage?.prompt_tokens_details
      ),
      completion_tokens_details: new ChatCompletion.Completion_tokens_details(
        chunk.usage?.completion_tokens_details
      ),
    });

    const response = new ChatCompletionChunk({
      id: chunk.id,
      model: chunk.model,
      created: chunk.created,
      system_fingerprint: chunk.system_fingerprint,
      object: chunk.object,
      service_tier: chunk.service_tier?.toString(),
      choices,
      usage,
    });

    Dart.stream_value(callbackId, response.serializeBinary());
  }

  Dart.stream_value_end(callbackId);
};

export default {
  init: (apiKey: string): GlobeAISdkState => {
    const openAI = new OpenAI({ apiKey });
    return { openAI };
  },
  functions: { openai_chat_complete, openai_chat_complete_stream },
};
