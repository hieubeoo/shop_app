import 'package:flutter/material.dart';
import 'package:shop_app/providers/product_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFav;
  ProductsGridView(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = showFav ? productData.itemsFavorite : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
