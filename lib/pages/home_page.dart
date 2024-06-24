import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page/products.dart';
import 'home_page/upload_page.dart';
import 'login_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  late String _username;
  late String _image;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    _username = await _storage.read(key: 'username') ?? 'Guest';
    _image = await _storage.read(key: 'image') ?? '';
    setState(() {
      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _navigateToProfile(BuildContext context) async {
    if (_username != _username) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Username mismatch!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
      _loadUserInfo();
    }
  }

  // Function to handle logout
  Future<void> _logout(BuildContext context) async {
    await _storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: _image.isNotEmpty
                        ? NetworkImage(_image)
                        : AssetImage('assets/default_avatar1.jpg'),
                  ),
                  SizedBox(width: 10),
                  Text(_username),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => _navigateToProfile(context),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => _logout(context),
                ),
              ],
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                ProductPage(),
                UploadPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          );
  }
}
