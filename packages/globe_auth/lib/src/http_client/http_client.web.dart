import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart' as http;

http.Client getHttpClient() {
  return http.BrowserClient()..withCredentials = true;
}
