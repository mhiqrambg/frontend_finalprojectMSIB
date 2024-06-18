import 'package:flutter/material.dart';

import '../../models/products/upload_request.dart';
import '../../models/products/upload_response.dart';
import '../../services/api_service.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlImageController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();

  int _categoryId = 1; // Ganti dengan nilai kategori default yang sesuai

  ApiService _apiService = ApiService(); // Buat instance ApiService

  void _submitForm() async {
    String name = _nameController.text.trim();
    String urlImage = _urlImageController.text.trim();
    int qty = int.parse(_qtyController.text.trim());
    String createdBy = _createdByController.text.trim();

    var request = UploadRequest(
      categoryId: _categoryId,
      name: name,
      urlImage: urlImage,
      qty: qty,
      createdBy: createdBy,
    );

    try {
      UploadResponse response = await _apiService.uploadData(request);

      // Tampilkan pesan sukses
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Successful'),
            content:
                Text('ID: ${response.data.id}, Name: ${response.data.name}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Tutup dialog
                  Navigator.of(context).pop();
                  // Reset nilai controller setelah dialog ditutup
                  _nameController.clear();
                  _urlImageController.clear();
                  _qtyController.clear();
                  _createdByController.clear();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Tampilkan pesan error jika gagal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Failed'),
            content: Text('Error: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _urlImageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _createdByController,
              decoration: InputDecoration(labelText: 'Created By'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
