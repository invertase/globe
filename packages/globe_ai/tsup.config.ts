import { defineConfig } from "tsup";

export default defineConfig({
  entry: ["lib/globe_ai.ts"], // Adjust this to your entry file
  format: ["esm"], // or "cjs" depending on your needs
  minify: false, // Optional, for smaller output
  sourcemap: false, // Optional, set to true if debugging
  bundle: true, // Ensures bundling
  splitting: false, // Prevents multiple output files
  treeshake: true, // Removes unused code
  clean: true, // Cleans output directory before build
  dts: false, // Set to true if you need TypeScript declaration files
  noExternal: [/.*/], // Include all dependencies in the bundle
  platform: "browser",
});
