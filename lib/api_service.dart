import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://your-api-url.com"; // Thay đổi URL API của bạn

  // Phương thức đăng nhập
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Trả về dữ liệu khi đăng nhập thành công
    } else {
      return null; // Trả về null nếu có lỗi
    }
  }

  // Phương thức đăng ký
  Future<Map<String, dynamic>?> signUp(String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Trả về dữ liệu khi đăng ký thành công
    } else {
      return null; // Trả về null nếu có lỗi
    }
  }
}
