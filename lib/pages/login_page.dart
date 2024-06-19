import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';
import '../services/api_service.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String _message = '';
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
      _message = ''; // Clear previous error message
    });

    try {
      LoginRequestModel request = LoginRequestModel(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      LoginResponseModel response = await _apiService.login(request);

      // Save token, username, and image securely on the user's device
      await _storage.write(key: 'token', value: response.token);
      await _storage.write(key: 'username', value: response.user.username);
      await _storage.write(key: 'image', value: response.user.image);

      // Navigate to home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      setState(() {
        _message = 'Login failed: $e'; // Display error message
      });
      // Handle login error if needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToSignUpPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/logo.png', // Adjust this path to your logo
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
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
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Login'),
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
