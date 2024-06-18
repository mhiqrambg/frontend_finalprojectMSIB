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
      // Sort products by categoryId
      products = List.from(productsResponse.result)
        ..sort((a, b) => a.categoryId.compareTo(b.categoryId));
      setState(() {
        products = products;
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
      body: RefreshIndicator(
        onRefresh: fetchProducts,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return ListTile(
              leading: Container(
                width: 60, // Adjust as needed
                height: 80, // Adjust as needed
                child: Image.network(
                  product.urlImage,
                  fit: BoxFit.cover, // Or your preferred BoxFit
                ),
              ),
              title: Text(product.name),
              subtitle: Text('Stock: ${product.qty}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProductPage(product: product),
                    ),
                  );
                  // Reload products after returning from update page
                  fetchProducts();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
