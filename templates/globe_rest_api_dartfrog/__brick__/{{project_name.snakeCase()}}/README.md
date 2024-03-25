# {{project_name}}

This project, `{{project_name}}`, utilizes DartFrog to create a high-performance, server-side RESTful API with Dart. DartFrog allows for building scalable web applications with minimal boilerplate, supporting hot reload and easy deployment.

## Getting Started

Before diving into `{{project_name}}`, ensure Dart is installed on your machine. DartFrog relies on Dart for development and deployment.

### Installation

Clone this repository and navigate to the `{{project_name.snakeCase()}}` directory. Install dependencies with:

```bash
dart pub get
```

### Development

Start the server in development mode with hot reload enabled:

```bash
dart_frog dev
```

Your server will be available at `http://localhost:8080`, and changes you make to your code will be automatically reloaded.

## Project Structure

- `routes/`: Contains the route handlers for your application. DartFrog routes are organized by file in this directory, with `index.dart` as the entry point.

{{#if include_logging}}

- Logging support is integrated, enhancing debugging and monitoring capabilities.
{{/if}}

{{#if support_wildcard_routes}}

- A wildcard route handler named `{{wildcard_route_name}}` is included to demonstrate dynamic routing capabilities.
{{/if}}

{{#if include_json_serializable}}

- Utilizes `json_serializable` for seamless JSON serialization, simplifying data handling between the front-end and backend.
{{/if}}

{{#if form_data_handling != 'none'}}

- Form data processing is configured to support `{{form_data_handling}}`, facilitating easier file uploads and form submissions.
{{/if}}

## Contributing

Contributions to `{{project_name}}` are welcome! Feel free to fork this repository, make your changes, and submit a pull request.

## License

`{{project_name}}` is released under the MIT License. For more details, see the `LICENSE` file in this directory.
