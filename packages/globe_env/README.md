# Globe Env

A package which provides an interface around the available Globe Environment variables.

This package is only intended for IO environments (e.g. server).

## Usage

Install the package:

```bash
dart pub add globe_env
```

### API

- **`GlobeEnv.port`**: Attempts to parse the `PORT` environment vaiable as an int. Defaults to 8080.
- **`GlobeEnv.isGlobeRuntime`**: Returns a boolean whether `GLOBE` is set as an environment variable. If true, indicates the environment is running on Globe.
- **`GlobeEnv.hostname`**: The hostname of the application running on Globe.
- **`GlobeEnv.cronId`**: If set, the cron job identifier which invoked the application.
- **`GlobeEnv.cronName`**: If set, the name of the cron job which invoked the application.
- **`GlobeEnv.cronSchedule`**: If set, the cron job schedule (e.g. `* * * * *`) which invoked the application.
- **`GlobeEnv.cronEventId`**: If set, the unique cron job event ID which invoked the application.
