import 'package:flutter/material.dart';
import '../widgets/product_gird.dart';

class FavoriteScreen extends StatelessWidget {
  final _showOnlyFavorites = true;
  @override
  Widget build(BuildContext context) {
    return ProductsGrid(_showOnlyFavorites);
  }
}
