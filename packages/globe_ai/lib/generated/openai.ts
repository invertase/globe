/**
 * Generated by the protoc-gen-ts.  DO NOT EDIT!
 * compiler version: 5.29.3
 * source: openai.proto
 * git: https://github.com/thesayyn/protoc-gen-ts */
import * as pb_1 from "google-protobuf";
export enum Compatibility {
    STRICT = 0,
    COMPATIBLE = 1
}
export class OpenAIConfig extends pb_1.Message {
    #one_of_decls: number[][] = [];
    constructor(data?: any[] | {
        base_url?: string;
        api_key?: string;
        name?: string;
        organization?: string;
        project?: string;
        headers?: Map<string, string>;
        compatibility?: Compatibility;
    }) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("base_url" in data && data.base_url != undefined) {
                this.base_url = data.base_url;
            }
            if ("api_key" in data && data.api_key != undefined) {
                this.api_key = data.api_key;
            }
            if ("name" in data && data.name != undefined) {
                this.name = data.name;
            }
            if ("organization" in data && data.organization != undefined) {
                this.organization = data.organization;
            }
            if ("project" in data && data.project != undefined) {
                this.project = data.project;
            }
            if ("headers" in data && data.headers != undefined) {
                this.headers = data.headers;
            }
            if ("compatibility" in data && data.compatibility != undefined) {
                this.compatibility = data.compatibility;
            }
        }
        if (!this.headers)
            this.headers = new Map();
    }
    get base_url() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set base_url(value: string) {
        pb_1.Message.setField(this, 1, value);
    }
    get api_key() {
        return pb_1.Message.getFieldWithDefault(this, 2, "") as string;
    }
    set api_key(value: string) {
        pb_1.Message.setField(this, 2, value);
    }
    get name() {
        return pb_1.Message.getFieldWithDefault(this, 3, "") as string;
    }
    set name(value: string) {
        pb_1.Message.setField(this, 3, value);
    }
    get organization() {
        return pb_1.Message.getFieldWithDefault(this, 4, "") as string;
    }
    set organization(value: string) {
        pb_1.Message.setField(this, 4, value);
    }
    get project() {
        return pb_1.Message.getFieldWithDefault(this, 5, "") as string;
    }
    set project(value: string) {
        pb_1.Message.setField(this, 5, value);
    }
    get headers() {
        return pb_1.Message.getField(this, 6) as any as Map<string, string>;
    }
    set headers(value: Map<string, string>) {
        pb_1.Message.setField(this, 6, value as any);
    }
    get compatibility() {
        return pb_1.Message.getFieldWithDefault(this, 7, Compatibility.STRICT) as Compatibility;
    }
    set compatibility(value: Compatibility) {
        pb_1.Message.setField(this, 7, value);
    }
    static fromObject(data: {
        base_url?: string;
        api_key?: string;
        name?: string;
        organization?: string;
        project?: string;
        headers?: {
            [key: string]: string;
        };
        compatibility?: Compatibility;
    }): OpenAIConfig {
        const message = new OpenAIConfig({});
        if (data.base_url != null) {
            message.base_url = data.base_url;
        }
        if (data.api_key != null) {
            message.api_key = data.api_key;
        }
        if (data.name != null) {
            message.name = data.name;
        }
        if (data.organization != null) {
            message.organization = data.organization;
        }
        if (data.project != null) {
            message.project = data.project;
        }
        if (typeof data.headers == "object") {
            message.headers = new Map(Object.entries(data.headers));
        }
        if (data.compatibility != null) {
            message.compatibility = data.compatibility;
        }
        return message;
    }
    toObject() {
        const data: {
            base_url?: string;
            api_key?: string;
            name?: string;
            organization?: string;
            project?: string;
            headers?: {
                [key: string]: string;
            };
            compatibility?: Compatibility;
        } = {};
        if (this.base_url != null) {
            data.base_url = this.base_url;
        }
        if (this.api_key != null) {
            data.api_key = this.api_key;
        }
        if (this.name != null) {
            data.name = this.name;
        }
        if (this.organization != null) {
            data.organization = this.organization;
        }
        if (this.project != null) {
            data.project = this.project;
        }
        if (this.headers != null) {
            data.headers = (Object.fromEntries)(this.headers);
        }
        if (this.compatibility != null) {
            data.compatibility = this.compatibility;
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.base_url.length)
            writer.writeString(1, this.base_url);
        if (this.api_key.length)
            writer.writeString(2, this.api_key);
        if (this.name.length)
            writer.writeString(3, this.name);
        if (this.organization.length)
            writer.writeString(4, this.organization);
        if (this.project.length)
            writer.writeString(5, this.project);
        for (const [key, value] of this.headers) {
            writer.writeMessage(6, this.headers, () => {
                writer.writeString(1, key);
                writer.writeString(2, value);
            });
        }
        if (this.compatibility != Compatibility.STRICT)
            writer.writeEnum(7, this.compatibility);
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): OpenAIConfig {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new OpenAIConfig();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.base_url = reader.readString();
                    break;
                case 2:
                    message.api_key = reader.readString();
                    break;
                case 3:
                    message.name = reader.readString();
                    break;
                case 4:
                    message.organization = reader.readString();
                    break;
                case 5:
                    message.project = reader.readString();
                    break;
                case 6:
                    reader.readMessage(message, () => pb_1.Map.deserializeBinary(message.headers as any, reader, reader.readString, reader.readString));
                    break;
                case 7:
                    message.compatibility = reader.readEnum();
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): OpenAIConfig {
        return OpenAIConfig.deserialize(bytes);
    }
}
export class FileInput extends pb_1.Message {
    #one_of_decls: number[][] = [];
    constructor(data?: any[] | {
        name?: string;
        mime_type?: string;
        data?: Uint8Array;
    }) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("name" in data && data.name != undefined) {
                this.name = data.name;
            }
            if ("mime_type" in data && data.mime_type != undefined) {
                this.mime_type = data.mime_type;
            }
            if ("data" in data && data.data != undefined) {
                this.data = data.data;
            }
        }
    }
    get name() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set name(value: string) {
        pb_1.Message.setField(this, 1, value);
    }
    get mime_type() {
        return pb_1.Message.getFieldWithDefault(this, 2, "") as string;
    }
    set mime_type(value: string) {
        pb_1.Message.setField(this, 2, value);
    }
    get data() {
        return pb_1.Message.getFieldWithDefault(this, 3, new Uint8Array(0)) as Uint8Array;
    }
    set data(value: Uint8Array) {
        pb_1.Message.setField(this, 3, value);
    }
    static fromObject(data: {
        name?: string;
        mime_type?: string;
        data?: Uint8Array;
    }): FileInput {
        const message = new FileInput({});
        if (data.name != null) {
            message.name = data.name;
        }
        if (data.mime_type != null) {
            message.mime_type = data.mime_type;
        }
        if (data.data != null) {
            message.data = data.data;
        }
        return message;
    }
    toObject() {
        const data: {
            name?: string;
            mime_type?: string;
            data?: Uint8Array;
        } = {};
        if (this.name != null) {
            data.name = this.name;
        }
        if (this.mime_type != null) {
            data.mime_type = this.mime_type;
        }
        if (this.data != null) {
            data.data = this.data;
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.name.length)
            writer.writeString(1, this.name);
        if (this.mime_type.length)
            writer.writeString(2, this.mime_type);
        if (this.data.length)
            writer.writeBytes(3, this.data);
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): FileInput {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new FileInput();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.name = reader.readString();
                    break;
                case 2:
                    message.mime_type = reader.readString();
                    break;
                case 3:
                    message.data = reader.readBytes();
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): FileInput {
        return FileInput.deserialize(bytes);
    }
}
export class TextInput extends pb_1.Message {
    #one_of_decls: number[][] = [];
    constructor(data?: any[] | {
        text?: string;
    }) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("text" in data && data.text != undefined) {
                this.text = data.text;
            }
        }
    }
    get text() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set text(value: string) {
        pb_1.Message.setField(this, 1, value);
    }
    static fromObject(data: {
        text?: string;
    }): TextInput {
        const message = new TextInput({});
        if (data.text != null) {
            message.text = data.text;
        }
        return message;
    }
    toObject() {
        const data: {
            text?: string;
        } = {};
        if (this.text != null) {
            data.text = this.text;
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.text.length)
            writer.writeString(1, this.text);
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): TextInput {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new TextInput();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.text = reader.readString();
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): TextInput {
        return TextInput.deserialize(bytes);
    }
}
export class AIMessage extends pb_1.Message {
    #one_of_decls: number[][] = [];
    constructor(data?: any[] | {
        role?: string;
        content?: AIInput[];
    }) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [2], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("role" in data && data.role != undefined) {
                this.role = data.role;
            }
            if ("content" in data && data.content != undefined) {
                this.content = data.content;
            }
        }
    }
    get role() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set role(value: string) {
        pb_1.Message.setField(this, 1, value);
    }
    get content() {
        return pb_1.Message.getRepeatedWrapperField(this, AIInput, 2) as AIInput[];
    }
    set content(value: AIInput[]) {
        pb_1.Message.setRepeatedWrapperField(this, 2, value);
    }
    static fromObject(data: {
        role?: string;
        content?: ReturnType<typeof AIInput.prototype.toObject>[];
    }): AIMessage {
        const message = new AIMessage({});
        if (data.role != null) {
            message.role = data.role;
        }
        if (data.content != null) {
            message.content = data.content.map(item => AIInput.fromObject(item));
        }
        return message;
    }
    toObject() {
        const data: {
            role?: string;
            content?: ReturnType<typeof AIInput.prototype.toObject>[];
        } = {};
        if (this.role != null) {
            data.role = this.role;
        }
        if (this.content != null) {
            data.content = this.content.map((item: AIInput) => item.toObject());
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.role.length)
            writer.writeString(1, this.role);
        if (this.content.length)
            writer.writeRepeatedMessage(2, this.content, (item: AIInput) => item.serialize(writer));
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): AIMessage {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new AIMessage();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.role = reader.readString();
                    break;
                case 2:
                    reader.readMessage(message.content, () => pb_1.Message.addToRepeatedWrapperField(message, 2, AIInput.deserialize(reader), AIInput));
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): AIMessage {
        return AIMessage.deserialize(bytes);
    }
}
export class AIMessages extends pb_1.Message {
    #one_of_decls: number[][] = [];
    constructor(data?: any[] | {
        messages?: AIMessage[];
    }) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [1], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("messages" in data && data.messages != undefined) {
                this.messages = data.messages;
            }
        }
    }
    get messages() {
        return pb_1.Message.getRepeatedWrapperField(this, AIMessage, 1) as AIMessage[];
    }
    set messages(value: AIMessage[]) {
        pb_1.Message.setRepeatedWrapperField(this, 1, value);
    }
    static fromObject(data: {
        messages?: ReturnType<typeof AIMessage.prototype.toObject>[];
    }): AIMessages {
        const message = new AIMessages({});
        if (data.messages != null) {
            message.messages = data.messages.map(item => AIMessage.fromObject(item));
        }
        return message;
    }
    toObject() {
        const data: {
            messages?: ReturnType<typeof AIMessage.prototype.toObject>[];
        } = {};
        if (this.messages != null) {
            data.messages = this.messages.map((item: AIMessage) => item.toObject());
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.messages.length)
            writer.writeRepeatedMessage(1, this.messages, (item: AIMessage) => item.serialize(writer));
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): AIMessages {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new AIMessages();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    reader.readMessage(message.messages, () => pb_1.Message.addToRepeatedWrapperField(message, 1, AIMessage.deserialize(reader), AIMessage));
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): AIMessages {
        return AIMessages.deserialize(bytes);
    }
}
export class AIInput extends pb_1.Message {
    #one_of_decls: number[][] = [[1, 2]];
    constructor(data?: any[] | ({} & (({
        text?: string;
        file?: never;
    } | {
        text?: never;
        file?: FileInput;
    })))) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("text" in data && data.text != undefined) {
                this.text = data.text;
            }
            if ("file" in data && data.file != undefined) {
                this.file = data.file;
            }
        }
    }
    get text() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set text(value: string) {
        pb_1.Message.setOneofField(this, 1, this.#one_of_decls[0], value);
    }
    get has_text() {
        return pb_1.Message.getField(this, 1) != null;
    }
    get file() {
        return pb_1.Message.getWrapperField(this, FileInput, 2) as FileInput;
    }
    set file(value: FileInput) {
        pb_1.Message.setOneofWrapperField(this, 2, this.#one_of_decls[0], value);
    }
    get has_file() {
        return pb_1.Message.getField(this, 2) != null;
    }
    get input() {
        const cases: {
            [index: number]: "none" | "text" | "file";
        } = {
            0: "none",
            1: "text",
            2: "file"
        };
        return cases[pb_1.Message.computeOneofCase(this, [1, 2])];
    }
    static fromObject(data: {
        text?: string;
        file?: ReturnType<typeof FileInput.prototype.toObject>;
    }): AIInput {
        const message = new AIInput({});
        if (data.text != null) {
            message.text = data.text;
        }
        if (data.file != null) {
            message.file = FileInput.fromObject(data.file);
        }
        return message;
    }
    toObject() {
        const data: {
            text?: string;
            file?: ReturnType<typeof FileInput.prototype.toObject>;
        } = {};
        if (this.text != null) {
            data.text = this.text;
        }
        if (this.file != null) {
            data.file = this.file.toObject();
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.has_text)
            writer.writeString(1, this.text);
        if (this.has_file)
            writer.writeMessage(2, this.file, () => this.file.serialize(writer));
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): AIInput {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new AIInput();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.text = reader.readString();
                    break;
                case 2:
                    reader.readMessage(message.file, () => message.file = FileInput.deserialize(reader));
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): AIInput {
        return AIInput.deserialize(bytes);
    }
}
export class EitherMessagesOrPrompt extends pb_1.Message {
    #one_of_decls: number[][] = [[1, 2]];
    constructor(data?: any[] | ({} & (({
        prompt?: string;
        messages?: never;
    } | {
        prompt?: never;
        messages?: AIMessages;
    })))) {
        super();
        pb_1.Message.initialize(this, Array.isArray(data) ? data : [], 0, -1, [], this.#one_of_decls);
        if (!Array.isArray(data) && typeof data == "object") {
            if ("prompt" in data && data.prompt != undefined) {
                this.prompt = data.prompt;
            }
            if ("messages" in data && data.messages != undefined) {
                this.messages = data.messages;
            }
        }
    }
    get prompt() {
        return pb_1.Message.getFieldWithDefault(this, 1, "") as string;
    }
    set prompt(value: string) {
        pb_1.Message.setOneofField(this, 1, this.#one_of_decls[0], value);
    }
    get has_prompt() {
        return pb_1.Message.getField(this, 1) != null;
    }
    get messages() {
        return pb_1.Message.getWrapperField(this, AIMessages, 2) as AIMessages;
    }
    set messages(value: AIMessages) {
        pb_1.Message.setOneofWrapperField(this, 2, this.#one_of_decls[0], value);
    }
    get has_messages() {
        return pb_1.Message.getField(this, 2) != null;
    }
    get input() {
        const cases: {
            [index: number]: "none" | "prompt" | "messages";
        } = {
            0: "none",
            1: "prompt",
            2: "messages"
        };
        return cases[pb_1.Message.computeOneofCase(this, [1, 2])];
    }
    static fromObject(data: {
        prompt?: string;
        messages?: ReturnType<typeof AIMessages.prototype.toObject>;
    }): EitherMessagesOrPrompt {
        const message = new EitherMessagesOrPrompt({});
        if (data.prompt != null) {
            message.prompt = data.prompt;
        }
        if (data.messages != null) {
            message.messages = AIMessages.fromObject(data.messages);
        }
        return message;
    }
    toObject() {
        const data: {
            prompt?: string;
            messages?: ReturnType<typeof AIMessages.prototype.toObject>;
        } = {};
        if (this.prompt != null) {
            data.prompt = this.prompt;
        }
        if (this.messages != null) {
            data.messages = this.messages.toObject();
        }
        return data;
    }
    serialize(): Uint8Array;
    serialize(w: pb_1.BinaryWriter): void;
    serialize(w?: pb_1.BinaryWriter): Uint8Array | void {
        const writer = w || new pb_1.BinaryWriter();
        if (this.has_prompt)
            writer.writeString(1, this.prompt);
        if (this.has_messages)
            writer.writeMessage(2, this.messages, () => this.messages.serialize(writer));
        if (!w)
            return writer.getResultBuffer();
    }
    static deserialize(bytes: Uint8Array | pb_1.BinaryReader): EitherMessagesOrPrompt {
        const reader = bytes instanceof pb_1.BinaryReader ? bytes : new pb_1.BinaryReader(bytes), message = new EitherMessagesOrPrompt();
        while (reader.nextField()) {
            if (reader.isEndGroup())
                break;
            switch (reader.getFieldNumber()) {
                case 1:
                    message.prompt = reader.readString();
                    break;
                case 2:
                    reader.readMessage(message.messages, () => message.messages = AIMessages.deserialize(reader));
                    break;
                default: reader.skipField();
            }
        }
        return message;
    }
    serializeBinary(): Uint8Array {
        return this.serialize();
    }
    static deserializeBinary(bytes: Uint8Array): EitherMessagesOrPrompt {
        return EitherMessagesOrPrompt.deserialize(bytes);
    }
}
