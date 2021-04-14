import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_gird.dart';
import '../providers/product_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  final _showOnlyFavorites = false;
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () => _refreshProducts(context),
      child: FutureBuilder(
          future: Provider.of<ProductsProvider>(context, listen: false)
              .fetAndSetProducts(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text(dataSnapshot.error.toString()),
                );
              } else {
                return ProductsGrid(_showOnlyFavorites, '');
              }
            }
          }),
    );
  }
}
