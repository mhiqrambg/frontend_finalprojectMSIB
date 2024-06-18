import 'package:flutter/material.dart';
import '../../models/products/products_response.dart';
import '../../services/api_service.dart';
import 'update_product.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Result> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final productsResponse = await ApiService.getProducts();
      setState(() {
        products = productsResponse.result;
      });
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error appropriately, e.g., show a snackbar or alert dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return ListTile(
            leading: Image.network(product.urlImage),
            title: Text(product.name),
            subtitle: Text('Stock: ${product.qty}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProductPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
