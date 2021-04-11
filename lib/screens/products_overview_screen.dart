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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false)
            .fetAndSetProducts(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Something wrong :))'),
              );
            } else {
              return ProductsGrid(_showOnlyFavorites);
            }
          }
        });
    // });
  }
}
