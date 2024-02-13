## 0.0.7

 - **FIX**: switch to event source log streaming ([#41](https://github.com/invertase/globe/issues/41)). ([6b6709f9](https://github.com/invertase/globe/commit/6b6709f948e9365a6727ab08d725d9e0b1d5fd53))

## 0.0.6

 - **FEAT**(globe_cli): API token support for cli login and deploy ([#36](https://github.com/invertase/globe/issues/36)). ([48b6e41a](https://github.com/invertase/globe/commit/48b6e41a49dd15ad75f490b8f180338bdd0f9438))

## 0.0.5

 - **FEAT**(globe_cli): Added login url in output of login command ([#34](https://github.com/invertase/globe/issues/34)). ([5294dcbe](https://github.com/invertase/globe/commit/5294dcbe53c2866b491818ad4fc410c6a60e0bc4))

## 0.0.4

 - **FEAT**(globe_cli): Show build-log hint when deployment fails ([#33](https://github.com/invertase/globe/issues/33)). ([19e882d8](https://github.com/invertase/globe/commit/19e882d84022d529335db01ce1dc29dd9da8342a))
 - **FEAT**(globe_cli): Show deployment statuses while deploying ([#29](https://github.com/invertase/globe/issues/29)). ([d8bace79](https://github.com/invertase/globe/commit/d8bace793f8cb905dc52a7ed4a8e0876c9b5e936))

## 0.0.3

 - **FIX**: update tests. ([e2d34290](https://github.com/invertase/globe/commit/e2d34290eb5d24378c01ee48f500dd73bf4ef7dc))
 - **FIX**: spell check. ([cc763c5e](https://github.com/invertase/globe/commit/cc763c5ec0d9f294174ba4f24aa11d20c0a8af17))
 - **FEAT**: handle cli redirect. ([b25514d8](https://github.com/invertase/globe/commit/b25514d8ff522a48b840333365560807b3de56d9))
 - **FEAT**(globe_cli): Add --logs for globe deploy ([#28](https://github.com/invertase/globe/issues/28)). ([479b11e7](https://github.com/invertase/globe/commit/479b11e7b3391d4a8ee05847d0cd53b9e37aac80))

## 0.0.2+1

 - **REFACTOR**: Remove logging streaming from CLI ([#13](https://github.com/invertase/globe/issues/13)). ([3e86f9d2](https://github.com/invertase/globe/commit/3e86f9d2d8ef820b8ff319eb137c9afa4605c732))

## 0.0.2

 - Manual version to fix `globe update` command.

 - **FIX**(globe_cli): Bad state no element error on deployment fixed ([#8](https://github.com/invertase/globe/issues/8)). ([6856942b](https://github.com/invertase/globe/commit/6856942b9c70d8b69c4cc663afbcab3782a45d39))

## 0.0.1+1

 - **DOCS**: Add CLI readme ([#5](https://github.com/invertase/globe/issues/5)). ([d6216e67](https://github.com/invertase/globe/commit/d6216e6774bf430b76ab792b28c57352e79c5d04))

## 0.0.1

 - Graduate package to a stable release. See pre-releases prior to this version for changelog entries.

# 0.0.1-dev.26

- `globe deploy` now streams build logs
- new command: `globe build-logs -d <deploymentId>`

# 0.0.1-dev.25

- `globe deploy` now streams build logs
- new command: `globe build-logs -d <deploymentId>`

# 0.0.1-dev.24

- `globe deploy` now streams build logs
- new command: `globe build-logs -d <deploymentId>`

# 0.0.1-dev.23

- Fixed update request on latest version

# 0.0.1-dev.22

- Improved logging of api errors

# 0.0.1-dev.21

- Nested `.gitignore` files are now respected.

# 0.0.1-dev.20

- Fix an issue with too many open files by pooling open file reads.

# 0.0.1-dev.19

- Deployment archives now ignore all files in `.gitignore` (including nested), the following directory glob matches are also excluded by default:

```
**.map
**.git**
**.dart_tool**
**.packages**
**.idea**
**.vscode**
**build**
**android**
**ios**
**linux**
**macos**
**windows**
```

# 0.0.1-dev.18

- Improves deployment output, shows deployment target, realtime status and preview URL.
- Removes internal checks of Melos & Build Runner, these are now handled server side.

# 0.0.1-dev.17

- Fix update message showing when there is no update.

# 0.0.1-dev.16

- CLI now supports Monorepos. Run globe commands from the root of your project and specify the project path of the project. This change has been made to better support CLI and GitHub projects.
- Removed max upload size check.
- CLI now respects `.gitignore` files (`.dart_tool` and `packages` are always ignored regardless).
- CLI now detects Build Runner & Melos, and updates project settings (to be implemented server side).

# 0.0.1-dev.5

- Fix an error with http requests.

# 0.0.1-dev.4

- The command line now warns if a new version is available.
- Uses project settings to validate the current project settings.
- Updates API responses to match the API updates.

# 0.0.1-dev.3

- Update deploy flow to handle changed project responses.
- Point to new local dev server in local mode.

# 0.0.1-dev.2

- Handle case where no organizations are found

# 0.0.1-dev.1

- Fixes and improvements

# 0.0.1-dev.0

- Initial version
