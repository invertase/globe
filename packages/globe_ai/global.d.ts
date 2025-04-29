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
}

export {};
