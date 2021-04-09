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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('MyShop'),
    //     actions: [
    // Consumer<Cart>(
    //   builder: (_, cart, ch) => Badge(
    //     child: ch,
    //     value: cart.itemCount.toString(),
    //   ),
    //   child: IconButton(
    //     icon: Icon(
    //       Icons.shopping_cart,
    //     ),
    //     onPressed: () {
    //       Navigator.of(context).pushNamed(CartScreen.routeName);
    //     },
    //   ),
    // ),
    //     PopupMenuButton(
    //       onSelected: (FilterOptions selectedValue) {
    //         setState(() {
    //           if (selectedValue == FilterOptions.Favorites) {
    //             _showOnlyFavorites = true;
    //           } else {
    //             _showOnlyFavorites = false;
    //           }
    //         });
    //       },
    //       icon: Icon(
    //         Icons.more_vert,
    //       ),
    //       itemBuilder: (_) => [
    //         PopupMenuItem(
    //           child: Text('Sản phẩm yêu thích'),
    //           value: FilterOptions.Favorites,
    //         ),
    //         PopupMenuItem(
    //           child: Text('Tất cả sản phẩm'),
    //           value: FilterOptions.All,
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    //   drawer: AppDrawer(),
    //   body: _isLoading
    //       ? Center(
    //           child: CircularProgressIndicator(
    //             backgroundColor: Colors.grey,
    //           ),
    //         )
    //       : ProductsGrid(_showOnlyFavorites),
    // );
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
