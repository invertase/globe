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
