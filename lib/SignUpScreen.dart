import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _selectedRole = 'Traveler';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Lưu trữ thông báo lỗi cho từng trường
  Map<String, String> _errorMessages = {};

  Future<void> _signUp() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Xóa lỗi cũ
    setState(() {
      _errorMessages.clear();
    });

    // Kiểm tra điều kiện nhập liệu
    if (firstName.isEmpty) {
      _errorMessages['firstName'] = "Vui lòng nhập First Name.";
    }
    if (lastName.isEmpty) {
      _errorMessages['lastName'] = "Vui lòng nhập Last Name.";
    }
    if (email.isEmpty) {
      _errorMessages['email'] = "Vui lòng nhập Email.";
    }
    if (password.isEmpty) {
      _errorMessages['password'] = "Vui lòng nhập Password.";
    }
    if (confirmPassword.isEmpty) {
      _errorMessages['confirmPassword'] = "Vui lòng nhập Confirm Password.";
    }
    if (password != confirmPassword) {
      _errorMessages['confirmPassword'] = "Mật khẩu không khớp.";
    }

    // Nếu có lỗi, không gửi yêu cầu API
    if (_errorMessages.isNotEmpty) {
      setState(() {});
      return;
    }

    // Gửi yêu cầu API nếu không có lỗi
    try {
      final response = await http.post(
        Uri.parse('https://api-ltdd.onrender.com/user/signup'),
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'role': _selectedRole,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Đăng ký thành công
        Navigator.pop(context); // Quay lại màn hình đăng nhập
      } else {
        // Thông báo lỗi chung nếu đăng ký thất bại
        setState(() {
          _errorMessages['general'] = "Đăng ký thất bại. Vui lòng thử lại.";
        });
      }
    } catch (error) {
      setState(() {
        _errorMessages['general'] = "Có lỗi xảy ra. Vui lòng thử lại.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 120, 233, 124),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 120, 233, 124),
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', height: 60),
                  ],
                ),
              ),
              Positioned(top: 100, right: 83, child: Image.asset('assets/line.png', height: 60)),
              Positioned(top: 70, right: 60, child: Image.asset('assets/cloud.png', height: 60)),
              Positioned(top: 50, right: 30, child: Image.asset('assets/maybay.png', height: 60)),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Traveler'),
                              value: 'Traveler',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Guide'),
                              value: 'Guide',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('First Name', _firstNameController, 'firstName'),
                      _buildTextField('Last Name', _lastNameController, 'lastName'),
                      _buildTextField('Email', _emailController, 'email'),
                      _buildTextField('Password', _passwordController, 'password', obscureText: true),
                      _buildTextField('Confirm Password', _confirmPasswordController, 'confirmPassword', obscureText: true),
                      if (_errorMessages.containsKey('general')) ...[
                        const SizedBox(height: 8),
                        Text(
                          _errorMessages['general']!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            side: const BorderSide(color: Color.fromARGB(255, 253, 253, 253)),
                          ),
                        ),
                        child: const Text(
                          'Already have an account? Sign in',
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 163, 210, 237)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String key, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            errorText: _errorMessages.containsKey(key) ? _errorMessages[key] : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
 