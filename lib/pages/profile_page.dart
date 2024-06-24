import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';
import '../models/profile_request.dart';
import '../models/profile_response.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  String _username = '';
  String _image = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    String? username = await _storage.read(key: 'username');
    String? image = await _storage.read(key: 'image');
    setState(() {
      _username = username ?? 'Guest';
      _image = image ?? '';
      _imageController.text = _image;
    });
  }

  Future<void> _updateProfile() async {
    String? token = await _storage.read(key: 'token');
    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    }

    ProfileRequestModel request = ProfileRequestModel(
      password: _passwordController.text,
      image: _imageController.text,
    );

    try {
      ProfileResponseModel response =
          await _apiService.updateProfile(_username, request, token);

      await _storage.write(key: 'token', value: response.token);
      await _storage.write(key: 'image', value: response.user.image);

      setState(() {
        _image = response.user.image;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')));

      Navigator.pop(context); // Pop the profile page to return to home
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: _image.isNotEmpty
                  ? NetworkImage(_image)
                  : AssetImage('assets/default_avatar.png') as ImageProvider,
              radius: 50,
            ),
            SizedBox(height: 20),
            Text('Username: $_username', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
