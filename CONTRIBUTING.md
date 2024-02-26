# Contribution Guidelines

**Note:** If these contribution guidelines are not followed your issue or PR might be closed, so
please read these instructions carefully.

_See also: [the Invertase code of conduct](https://github.com/invertase/meta/blob/main/CODE_OF_CONDUCT.md)_

## About

Globe is a global deployment platform for Dart & Flutter applications.

## Contribution types

### Bug Report

- If you find a bug, please first report it using [GitHub issues](https://github.com/invertase/globe/issues/new?assignees=&labels=bug%2Ctriage&template=bug_report.yml&title=fix%3A++).
  - First check if there is not already an issue for it; duplicated issues will be closed.

### Bug Fix

- If you'd like to submit a fix for a bug, please read the [How To](#how-to-contribute) for how to send a pull request.
- Indicate on the open issue that you are working on fixing the bug and the issue will be assigned to you.
- Write `Fix #xxxx` in your PR text, where xxxx is the issue number (if there is one).
- Include a test that isolates the bug and verifies that it was fixed.

### New Features

- If you'd like to add a feature to the library that doesn't already exist, feel free to describe the feature in a new [GitHub issue](https://github.com/invertase/globe/issues/new?assignees=&labels=feature+request%2Ctriage&template=feature_request.yml&title=feature%3A++).
- If you'd like to implement the new feature, please wait for feedback from the project maintainers before spending too much time writing the code. In some cases, enhancements may not align well with the project future development direction.
- If applicable, implement the code for the new feature and please read the [How To](#how-to-contribute).

### Documentation & Miscellaneous

- If you have suggestions for improvements to the documentation or examples (or something else), we would love to hear about it.
- As always first file a [GitHub issue](https://github.com/invertase/globe/issues/new).
- Implement the changes to the documentation, please read the [How To](#how-to-contribute).

## How To Contribute

### Requirements

- Linux, Mac OS X, or Windows.
- [Git](https://git-scm.com) (used for source version control).
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).

### Forking & cloning the repository

- Ensure all the dependencies described in the previous section are installed.
- Fork `https://github.com/invertase/globe` into your own GitHub account. If
  you already have a fork, and are now installing a development environment on
  a new machine, make sure you've updated your fork so that you don't use stale
  configuration options from long ago.
- `git clone git@github.com:<your_name_here>/globe.git`
- `git remote add upstream git@github.com:invertase/globe.git` (So that you
  fetch from the main repository, not your clone, when running `git fetch` or `git pull`

### Local development setup

This repository uses a tool called [Melos](https://github.com/invertase/melos) to manage
packages and dependencies, to set it up, run the following command from your terminal:

```shell
dart pub global activate melos
```

Next, at the root of your locally cloned repository bootstrap the projects dependencies:

```shell
melos bootstrap
```

The bootstrap command locally links all dependencies within the project without having to
provide manual [`dependency_overrides`](https://dart.dev/tools/pub/pubspec). This allows all
plugins, examples and tests to build from the local clone project. You should only need to run this
command once.

> You do not need to run `dart pub get` once bootstrap has been completed.

To activate the Globe CLI for local development, run the following command inside the package directory:

```sh
dart pub global activate --source="path" . --executable="globe"
```

### Performing changes

- Create a new local branch from `main` (e.g. `git checkout -b my-new-feature`)
- Make your changes (try to split them up with one PR per feature/fix).
- When committing your changes, make sure that each commit message is clear
  (e.g. `git commit -m 'docs: Add CONTRIBUTING.md'`).
- Push your new branch to your own fork into the same remote branch
  (e.g. `git push origin my-username.my-new-feature`, replace `origin` if you use another remote.)

### Publishing changes

1. Switch to `main` branch locally.
2. Run `git pull origin main`.
3. Run `git pull --tags` to make sure all tags are fetched.
5. Run `melos version` to automatically version packages and update Changelogs.
6. Run `melos publish` to dry run and confirm all packages are publishable.
7. Run `melos publish --no-dry-run`
8. Run `git push --follow-tags` to ensure the release is pushed to GitHub.

### Open a pull request

To send us a pull request:

- Go to `https://github.com/invertase/globe` and click the
  "Compare & pull request" button

Please make sure all your check-ins have detailed commit messages explaining the patch.

When naming the title of your pull request, please follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0-beta.4/)
guide.

Please also enable **“Allow edits by maintainers”**, this will help to speed-up the review
process as well.
