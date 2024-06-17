import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import package untuk menyimpan token secara aman
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../services/api_service.dart';
import 'home_page.dart';
import 'register_page.dart'; // Import halaman sign up
// Import halaman home jika belum diimpor

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _storage =
      FlutterSecureStorage(); // Instance untuk menyimpan token secara aman
  String _token = '';
  String _message = '';

  void _login() async {
    try {
      LoginRequestModel request = LoginRequestModel(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      LoginResponseModel response = await _apiService.login(request);

      setState(() {
        _token = response.token;
      });

      // Simpan token, username, dan foto di perangkat pengguna secara aman
      await _storage.write(key: 'token', value: _token);
      await _storage.write(key: 'username', value: response.user.username);
      await _storage.write(key: 'image', value: response.user.image);

      // Navigate ke halaman home_page setelah berhasil login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      setState(() {
        _message = 'Login failed: $e'; // Menampilkan pesan error
      });
      // Handle error login di sini jika perlu
    }
  }

  void _navigateToSignUpPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(), // Mengarahkan ke halaman sign up
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            Text(
              _message,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _navigateToSignUpPage,
              child: Text("Don't have an account? Sign up here"),
            ),
          ],
        ),
      ),
    );
  }
}
