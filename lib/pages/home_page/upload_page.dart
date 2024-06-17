import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Upload Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
