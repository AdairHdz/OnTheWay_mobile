import 'package:http/http.dart' as http;

abstract class Requestable {
  Future<http.Response> getResource(String endpoint);
  Future<http.Response> postResource(String endpoint, Object payload);
}


