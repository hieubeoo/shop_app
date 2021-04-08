import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Stack(
            children: [
              Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                    icon: product.isFavorite
                        ? Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border, color: Colors.grey),
                    onPressed: () {
                      product.toggleFavorite();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white38,
          title: Text(
            product.title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      // footer: GridTileBar(
      //   backgroundColor: Colors.grey,
      //   leading: Consumer<Product>(
      //     builder: (ctx, product, _) => IconButton(
      //       icon: Icon(
      //         product.isFavorite ? Icons.favorite : Icons.favorite_border,
      //       ),
      //       color: Theme.of(context).accentColor,
      //       onPressed: () {
      //         product.toggleFavorite();
      //       },
      //     ),
      //   ),
      //   title: Text(
      //     product.title,
      //     textAlign: TextAlign.center,
      //   ),
      //   trailing: IconButton(
      //     icon: Icon(
      //       Icons.shopping_cart,
      //     ),
      //     onPressed: () {
      //       cart.addItem(product.id, product.title, product.price);
      //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(
      //             'Đã Thêm vào giỏ hàng của bạn',
      //             textAlign: TextAlign.center,
      //           ),
      //           duration: Duration(seconds: 3),
      //           action: SnackBarAction(
      //             label: 'Hủy bỏ',
      //             onPressed: () {
      //               cart.removeSingleItem(product.id);
      //             },
      //           ),
      //         ),
      //       );
      //     },
      //     color: Theme.of(context).accentColor,
      //   ),
      // ),
    );
  }
}
