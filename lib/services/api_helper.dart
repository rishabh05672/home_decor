import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<dynamic> postApi(String url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }
}
