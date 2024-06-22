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

  int _categoryId = 1;
  List<String> _categories = ['Elektronik', 'Pakaian', 'Kendaraan'];

  ApiService _apiService = ApiService();
  String _errorMessage = '';

  void _submitForm() async {
    String name = _nameController.text.trim();
    String urlImage = _urlImageController.text.trim();
    int qty = int.tryParse(_qtyController.text.trim()) ?? 0;
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

      // Show success message
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
                  // Close dialog
                  Navigator.of(context).pop();

                  _nameController.clear();
                  _urlImageController.clear();
                  _qtyController.clear();
                  _createdByController.clear();
                  setState(() {
                    _errorMessage = '';
                  });
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Upload failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _urlImageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _createdByController,
              decoration: InputDecoration(labelText: 'Created By'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _categoryId,
              onChanged: (value) {
                setState(() {
                  _categoryId = value!;
                });
              },
              items: _categories.map((String category) {
                return DropdownMenuItem<int>(
                  value: _categories.indexOf(category) + 1,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
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
