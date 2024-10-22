## 0.0.13

 - **FEAT**: Add `--project` and `--org` options on commands that depend on "scope". ([#100](https://github.com/invertase/globe/issues/100)). ([a11ec775](https://github.com/invertase/globe/commit/a11ec775152c20e90b5979245baccdeb97dd9dc6))

## 0.0.12

 - **FIX**: PathNotFoundException when using templates ([#98](https://github.com/invertase/globe/issues/98)). ([a4d5e8f2](https://github.com/invertase/globe/commit/a4d5e8f2df97cfa0d7ea968b3e8ca5c7077ef3f9))
 - **FEAT**: Create project from CLI ([#87](https://github.com/invertase/globe/issues/87)). ([6214014d](https://github.com/invertase/globe/commit/6214014d01fb1aec04adbd2bd6b84e01b2c8478b))
 - **FEAT**: Pause & resume project from CLI ([#76](https://github.com/invertase/globe/issues/76)). ([42371f1a](https://github.com/invertase/globe/commit/42371f1a2744cdab8e39ef8c14e3e87d5069f253))

## 0.0.11

 - **FEAT**: Create project from CLI ([#87](https://github.com/invertase/globe/issues/87)). ([6214014d](https://github.com/invertase/globe/commit/6214014d01fb1aec04adbd2bd6b84e01b2c8478b))
 - **FEAT**: Pause & resume project from CLI ([#76](https://github.com/invertase/globe/issues/76)). ([42371f1a](https://github.com/invertase/globe/commit/42371f1a2744cdab8e39ef8c14e3e87d5069f253))

## 0.0.10

 - **FEAT**(globe_cli): paused project handle for deploy and build log ([#75](https://github.com/invertase/globe/issues/75)). ([f8e0c8de](https://github.com/invertase/globe/commit/f8e0c8de47c4570b609ebc7626c935dc8fdbd710))

## 0.0.9+6

 - **FIX**(globe_cli): Auth required before token checked bug ([#72](https://github.com/invertase/globe/issues/72)). ([d91b86c9](https://github.com/invertase/globe/commit/d91b86c93f74762f677499a4cc801951b536b258))
 - **FIX**: Rework gitignore matching ([#71](https://github.com/invertase/globe/issues/71)). ([75b6b744](https://github.com/invertase/globe/commit/75b6b744f08d080a4a5541666d7732579f21a6c7))

## 0.0.9+5

 - **REFACTOR**: Migrate to the latest realtime API ([#70](https://github.com/invertase/globe/issues/70)). ([6d4285a6](https://github.com/invertase/globe/commit/6d4285a6c79dafffd27c7f3ab5a9c4b12e9e0ef1))

## 0.0.9+4

 - **REFACTOR**: Add select all projects option ([#66](https://github.com/invertase/globe/issues/66)). ([c2e786ff](https://github.com/invertase/globe/commit/c2e786ffbb84ec6ee0747efbca4cfa9b7a8239af))
 - **REFACTOR**: Add default expiry date ([#65](https://github.com/invertase/globe/issues/65)). ([1d7274d4](https://github.com/invertase/globe/commit/1d7274d47fcda809f9f2022426b923151a39e263))

## 0.0.9+3

 - **FIX**(globe_cli): Changed local base url to localhost from 127.0.0.1 ([#62](https://github.com/invertase/globe/issues/62)). ([5467d63f](https://github.com/invertase/globe/commit/5467d63ff510ebdb22748fbe95ed95b99ea2393b))
 - **FIX**: Improve archiver gitignore matching ([#60](https://github.com/invertase/globe/issues/60)). ([c36b29c5](https://github.com/invertase/globe/commit/c36b29c59e63dacfc158dd3329237c1206954b3b))

## 0.0.9+2

 - **FIX**: Stream build logs over WS ([#55](https://github.com/invertase/globe/issues/55)). ([52fabbcb](https://github.com/invertase/globe/commit/52fabbcb7bb8119a1305eca8ed7791cad2ff0571))

## 0.0.9+1

 - **FIX**: Correctly handle windows path separators ([#52](https://github.com/invertase/globe/issues/52)). ([80750097](https://github.com/invertase/globe/commit/80750097ecc2a6ab472a982b5aa9eee63737d57e))

## 0.0.9

 - Graduate package to a stable release. See pre-releases prior to this version for changelog entries.

## 0.0.9-dev.1

 - **FIX**: correctly join paths on windows. ([72e82463](https://github.com/invertase/globe/commit/72e824631d5a50386dcb4e59c23007e30f8dd8ab))

## 0.0.9-dev.0+1

 - **FIX**: correctly handle windows path separators. ([e9bcd44b](https://github.com/invertase/globe/commit/e9bcd44ba9dce8c6b7ea49d266a1c9a6cf68f59d))

## 0.0.9

 - **FIX**: Remove need for scope validation ([#49](https://github.com/invertase/globe/issues/49)). ([cc0e715d](https://github.com/invertase/globe/commit/cc0e715da731585dc3fcb03ec8caf6e29af6308d))
 - **FIX**: Handle event-source exception gracefully ([#47](https://github.com/invertase/globe/issues/47)). ([dd006f46](https://github.com/invertase/globe/commit/dd006f46c935f02cbbb2966e69a7dfad26c2175f))
 - **FEAT**: Token create & delete from CLI ([#39](https://github.com/invertase/globe/issues/39)). ([e87e5a01](https://github.com/invertase/globe/commit/e87e5a01cfe21a4dbd113315967f5f41bc80d7a6))

## 0.0.8

 - **FEAT**: Token create & delete from CLI ([#39](https://github.com/invertase/globe/issues/39)). ([e87e5a01](https://github.com/invertase/globe/commit/e87e5a01cfe21a4dbd113315967f5f41bc80d7a6))

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
