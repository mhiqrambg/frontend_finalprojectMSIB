import 'package:flutter/material.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../services/api_service.dart';
import 'login_page.dart'; // Import halaman login_page.dart

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageController =
      TextEditingController(); // Jika diperlukan untuk image URL
  String _message = '';
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Buat objek RegisterRequestModel berdasarkan input dari pengguna
      RegisterRequestModel request = RegisterRequestModel(
        username: _usernameController.text,
        password: _passwordController.text,
        image: _imageController.text, // Sesuaikan dengan field yang diperlukan
      );

      // Kirim permintaan registrasi menggunakan ApiService
      RegisterResponseModel response = await _apiService.register(request);

      setState(() {
        _message = response.message; // Tampilkan pesan respons dari server
      });

      // Jika registrasi berhasil, kembalikan ke halaman login
      if (response.message == 'Sukses membuat akun') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      // Tangkap dan tampilkan pesan error dari backend
      setState(() {
        _message =
            'Failed to register: ${e.toString()}'; // Menampilkan pesan error
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
                    decoration: InputDecoration(
                        labelText:
                            'Image URL'), // Sesuaikan dengan label yang sesuai
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20),
                  Text(_message, style: TextStyle(color: Colors.red)),
                ],
              ),
      ),
    );
  }
}
