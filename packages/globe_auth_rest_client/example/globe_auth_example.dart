import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:dio/dio.dart';

void main() async {
  final client = GlobeAuthRestClient(Dio(
    BaseOptions(baseUrl: 'https://auth.globe.dev'),
  ));
  final response = await client.root.getOk();
  print(response.ok);
}
