import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page/category_page.dart';
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

  String _username = '';
  String _image = '';

  static List<Widget> _pages = <Widget>[
    CategoryPage(),
    UploadPage(),
    ProductPage(),
  ];

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
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to navigate to profile page and reload user info upon return
  Future<void> _navigateToProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
    _loadUserInfo(); // Reload user info when returning from profile page
  }

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'image');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: _image.isNotEmpty
                  ? NetworkImage(_image)
                  : AssetImage('assets/default_avatar.png') as ImageProvider,
            ),
            SizedBox(width: 10),
            Text(_username),
            GestureDetector(
              onTap: () => _navigateToProfile(context),
              child: Icon(Icons.edit),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
