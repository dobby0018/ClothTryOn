import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'http://192.168.45.173:5000'; // Update IP

  Future<Map<String, dynamic>> registerUser(User user) async {
    print('Raw JSON being sent: ${jsonEncode(user.toJson())}');
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registration successful'};
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'message': errorData['error']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to connect to server'};
    }
  }
}