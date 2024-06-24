import 'package:flutter/material.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      RegisterRequestModel request = RegisterRequestModel(
        username: _usernameController.text,
        password: _passwordController.text,
        image: _imageController.text,
      );

      RegisterResponseModel response = await _apiService.register(request);

      if (response.message == 'Sukses membuat akun') {
        setState(() {
          _message = ''; // Clear message on success
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registration Successful'),
              content: Text('Your account has been created successfully.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    // Close dialog
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _message = response.message; // Show error message from server
        });
      }
    } catch (e) {
      setState(() {
        _message = '$e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/signup.jpg',
                    height: 120,
                    width: 180,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _imageController,
                    decoration: InputDecoration(labelText: 'Image URL'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20),
                  if (_message.isNotEmpty)
                    Text(
                      _message,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
      ),
    );
  }
}
