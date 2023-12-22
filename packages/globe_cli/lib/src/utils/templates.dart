String _htmlTemplate(String body) => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Globe CLI</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      body {
        background: #0A0A0B;
        color: white;
        font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      }
    </style>
  </head>
  <body>
    $body
  </body>
</html>
''';

/// Returns a centered message string wrapped in a HTML template.
String cliCallbackTemplate(String message) => _htmlTemplate('''
<div style="height:100%;display:flex;align-items:center;justify-content:center;font-size:1.5rem;">
  $message
</div>
''');
