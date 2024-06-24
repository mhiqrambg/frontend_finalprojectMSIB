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
        child: ListView.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) =>
              Divider(), // Adding a divider between items
          itemBuilder: (context, index) {
            var product = products[index];
            return ListTile(
              leading: Container(
                width: 60,
                height: 90,
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
              subtitle: Text(
                'Stock: ${product.qty}\nCreated by: ${product.createdBy}\nUpdated by: ${product.updateBy}',
              ),
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
