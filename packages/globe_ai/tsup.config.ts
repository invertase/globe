import { defineConfig } from "tsup";
import { version, name } from "./package.json";
import { writeFileSync, readFileSync } from "fs";
import { resolve } from "path";

const outputFileName = `${name}_v${version}`;
const dartFileName = `${name}_source.dart`;

export default defineConfig({
  entry: {
    [outputFileName]: `lib/${name}.ts`,
  },
  onSuccess: async () => {
    const actualFile = resolve(`dist/${outputFileName}.js`);
    const dartFile = resolve(`lib/src/${dartFileName}`);

    // 1. read actual file content as string
    const jsSource = await readFileSync(actualFile, "utf8");

    // 2. Write the Dart version file
    writeFileSync(
      dartFile,
      `// GENERATED FILE — DO NOT MODIFY BY HAND
// This file was generated from package.json

const packageVersion = '${version}';

const packageSource = r'''
${jsSource}
''';
`
    );
    console.log(
      `\x1b[34mCLI\x1b[0m Wrote \x1b[32mlib/src/${dartFileName}\x1b[0m with version \x1b[32m${version}\x1b[0m`
    );
  },
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
