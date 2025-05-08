import { defineConfig } from "tsup";
import { version } from "./package.json";
import { writeFileSync } from "fs";
import { resolve } from "path";

// 1. Write the Dart version file
const dartVersionFile = resolve("lib/src/version.dart");
writeFileSync(
  dartVersionFile,
  `// GENERATED FILE — DO NOT MODIFY BY HAND
// This file was generated from package.json

const packageVersion = '${version}';
`
);
console.log(
  `\x1b[34mCLI\x1b[0m Wrote \x1b[32mlib/src/version.dart\x1b[0m with version \x1b[32m${version}\x1b[0m`
);

export default defineConfig({
  entry: {
    [`globe_ai_v${version}`]: "lib/globe_ai.ts",
  },
  // entry: ["lib/globe_ai.ts"], // Adjust this to your entry file
  format: ["esm"], // or "cjs" depending on your needs
  minify: true, // Optional, for smaller output
  sourcemap: false, // Optional, set to true if debugging
  bundle: true, // Ensures bundling
  splitting: false, // Prevents multiple output files
  treeshake: true, // Removes unused code
  clean: true, // Cleans output directory before build
  dts: false, // Set to true if you need TypeScript declaration files
  noExternal: [/.*/], // Include all dependencies in the bundle
  platform: "browser",
});
