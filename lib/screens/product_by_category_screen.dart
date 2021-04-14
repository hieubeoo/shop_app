import 'package:flutter/material.dart';
import '../widgets/product_gird.dart';

class ProductsByCategory extends StatelessWidget {
  final _showOnlyFavorites = false;
  static const routeName = '/product-by-category';
  @override
  Widget build(BuildContext context) {
    var _category =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          title: Text(_category['title']),
        ),
        body: ProductsGrid(_showOnlyFavorites, _category['category']));
  }
}
