import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/product_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context).fetAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm của bạn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return UserProductItem(
                id: allProducts.items[i].id,
                title: allProducts.items[i].title,
                imageUrl: allProducts.items[i].imageUrl,
              );
            },
            itemCount: allProducts.items.length,
          ),
        ),
      ),
    );
  }
}
