import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/product_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavs;
  final String category;

  ProductsGrid(this.showFavs, this.category);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    var products;
    if (widget.category.isEmpty) {
      products =
          widget.showFavs ? productsData.itemsFavorite : productsData.items;
    } else {
      products = productsData.productByCategory(widget.category);
    }
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: widget.category.isEmpty
          ? (ctx, i) {
              final product = widget.showFavs
                  ? productsData.itemsFavorite
                  : productsData.items;
              return ChangeNotifierProvider.value(
                value: product[i],
                child: ProductItem(),
              );
            }
          : (ctx, i) {
              final product = productsData.productByCategory(widget.category);
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
