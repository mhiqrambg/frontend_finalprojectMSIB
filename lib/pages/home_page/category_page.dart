import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Category Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}