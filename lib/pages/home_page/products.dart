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

      products = List.from(productsResponse.result)
        ..sort((a, b) => a.categoryId.compareTo(b.categoryId));
      setState(() {
        products = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
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
                width: 60,
                height: 80,
                child: Image.network(
                  product.urlImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/default_product.png',
                      fit: BoxFit.cover,
                    );
                  },
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
