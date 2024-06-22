import 'package:flutter/material.dart';
import '../../models/products/update_request.dart';
import '../../services/api_service.dart';
import '../../models/products/products_response.dart';

class UpdateProductPage extends StatefulWidget {
  final Result product;

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  late int _categoryId;
  late String _name;
  late String _urlImage;
  late int _qty;
  late String _updateBy;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.product.categoryId;
    _name = widget.product.name;
    _urlImage = widget.product.urlImage;
    _qty = widget.product.qty;
    _updateBy = 'belum di set';
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updateRequest = UpdateProductRequest(
        categoryId: _categoryId,
        name: _name,
        urlImage: _urlImage,
        qty: _qty,
        updateBy: _updateBy,
      );

      try {
        await ApiService.updateProduct(widget.product.id, updateRequest);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context); // Return to previous page (ProductPage)
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update product: $e')),
        );
      }
    }
  }

  Future<void> _deleteProduct() async {
    try {
      await ApiService.deleteProduct(widget.product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
      Navigator.pop(context); // Return to previous page (ProductPage)
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteProduct,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _urlImage,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _urlImage = value!;
                },
              ),
              TextFormField(
                initialValue: _qty.toString(),
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _qty = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _updateProduct,
                    child: Text('Update Product'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _deleteProduct,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // Text color
                    ),
                    child: Text('Delete Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
