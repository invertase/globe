declare global {
  interface DartGlobal {
    /**
     * Sends data back to Dart from JavaScript.
     *
     * @param callbackId - A unique identifier for the callback.
     * @param data - The data to send.
     * @returns {boolean} - Returns true if the data was sent successfully.
     */
    send_value: (callbackId: number, data: Uint8Array) => boolean;

    /**
     * Sends an error message back to Dart from JavaScript.
     *
     * @param callbackId - A unique identifier for the callback.
     * @param error - The error message to send.
     */
    send_error: (callbackId, error: string) => boolean;

    /**
     * Sends data back to Dart from JavaScript.
     *
     * @param callbackId - A unique identifier for the callback.
     * @param data - The data to send.
     * @returns {boolean} - Returns true if the data was sent successfully.
     */
    stream_value: (callbackId: number, data: Uint8Array) => boolean;

    /**
     * Sends data back to Dart from JavaScript.
     *
     * @param callbackId - A unique identifier for the callback.
     * @param data - The data to send.
     * @returns {boolean} - Returns true if the data was sent successfully.
     */
    stream_value_end: (
      callbackId: number,
      data?: Uint8Array | undefined
    ) => boolean;
  }

  const Dart: DartGlobal;

  const JsonPayload: {
    encode(value: unknown): Uint8Array | undefined;
    decode(value: Uint8Array): any;
  };
}

export {};
