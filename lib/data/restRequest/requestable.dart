import 'package:http/http.dart' as http;

abstract class Requestable {
  Future<http.Response> getResource(String endpoint, bool includeToken,
      [Map<String, String> requestHeaders,
      Map<String, String> queryParameters]);
  Future<http.Response> postResource(
      String endpoint, Object payload, bool includeToken,
      [Map<String, String> requestHeaders]);
  Future<http.Response> deleteResource(String endpoint, bool includeToken,
      [Map<String, String> requestHeaders]);
  Future<http.StreamedResponse> putImageResource(
      String endpoint, String filePath);
  Future<http.Response> patchResource(
      String endpoint, Object payload, bool includeToken,
      [Map<String, String> requestHeaders]);
  Future<http.Response> putResource(
      String endpoint, Object payload, bool includeToken,
      [Map<String, String> requestHeaders]);
}
