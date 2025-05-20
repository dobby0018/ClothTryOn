// api_service.dart
import 'dart:io';
import 'dart:convert';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;  
class ApiService {
  static const String baseUrl = 'http://192.168.0.113:5000';
  
// static Future<String> uploadImage(File imageFile) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');
  
//   if (token == null) {
//     throw Exception('Authentication required');
//   }

//   final uri = Uri.parse('$baseUrl/upload');
//   final request = http.MultipartRequest('POST', uri)
//     ..headers['Authorization'] = 'Bearer $token'
//     ..files.add(await http.MultipartFile.fromPath(
//       'image',
//       imageFile.path,
//       filename: path.basename(imageFile.path),
//     ));

//   final response = await request.send();
//   final responseBody = await response.stream.bytesToString();

//   if (response.statusCode == 200) {
//     return jsonDecode(responseBody)['file_id'] as String;
//   } else {
//     throw Exception('Upload failed: ${jsonDecode(responseBody)['error']}');
//   }
// }
static Future<String> uploadImage(File imageFile) async {
  // 1. Get stored token & email
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final email = prefs.getString('email'); // assume you've saved it earlier

  if (token == null) {
    throw Exception('Authentication required');
  }
  if (email == null || email.isEmpty) {
    throw Exception('Email required');
  }

  // 2. Build MultipartRequest
  final uri = Uri.parse('$baseUrl/upload');
  final request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = 'Bearer $token'
    // 3. Add form fields (text data)
    ..fields['email'] = email
    // 4. Add the file itself
    ..files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        filename: path.basename(imageFile.path),
      ),
    );

  // 5. Send & handle response
  final streamedResponse = await request.send();
  final responseBody = await streamedResponse.stream.bytesToString();

  if (streamedResponse.statusCode == 200) {
    return jsonDecode(responseBody)['file_id'] as String;
  } else {
    final err = jsonDecode(responseBody)['error'] ?? 'Unknown error';
    throw Exception('Upload failed: $err');
  }
}
  Future<Map<String, dynamic>> registerUser(User user) async {
    print('Raw JSON being sent: ${jsonEncode(user.toJson())}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
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
  static Future<Map<String, dynamic>> login(
      String email, String password, String userType) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'user_type': userType,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'token': data['token'],
        'user_type': data['user']['user_type'],
        'user_name': data['user']['name'],
        'email'     : data['user']['email'], 
      };
    } else {
      throw Exception(json.decode(response.body)['error']);
    }
  }

  static Future<List<dynamic>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
   static Future<List<Product>> getProducts() async {
    final uri = Uri.parse('$baseUrl/api/products');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  /// Helper to build full image URL from imageId
  static String getImageUrl(String imageId) {
    return '$baseUrl/api/images/$imageId';
  }
}