import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  final String category;

  ProductsGrid(this.showFavs, this.category);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    var products;
    if (category.isEmpty) {
      products = showFavs ? productsData.itemsFavorite : productsData.items;
    } else {
      products = productsData.productByCategory(category);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: category.isEmpty
          ? (ctx, i) {
              final product =
                  showFavs ? productsData.itemsFavorite : productsData.items;
              return ChangeNotifierProvider.value(
                value: product[i],
                child: ProductItem(),
              );
            }
          : (ctx, i) {
              final product = productsData.productByCategory(category);
              return ChangeNotifierProvider.value(
                value: product[i],
                child: ProductItem(),
              );
            },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
    );
  }
}
