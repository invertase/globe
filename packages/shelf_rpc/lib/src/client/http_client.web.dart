import 'package:http/browser_client.dart' as http;
import 'package:http/http.dart' as http;

/// Creates a new [http.Client] instance for the web using
/// the browser client with credentials enabled.
http.Client createHttpClient() {
  return http.BrowserClient()..withCredentials = true;
}
