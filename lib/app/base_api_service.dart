import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApiService {
  final String baseUrl;

  BaseApiService({required this.baseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('GET request error: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body, bool asForm = false}) async {
    try {
      final requestHeaders = headers ?? {};
      if (asForm) {
        requestHeaders['Content-Type'] = 'application/x-www-form-urlencoded';
      } else {
        requestHeaders['Content-Type'] = 'application/json';
      }
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: requestHeaders,
        body: asForm ? body : jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('POST request error: $e');
    }
  }

  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('PUT request error: $e');
    }
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('DELETE request error: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
