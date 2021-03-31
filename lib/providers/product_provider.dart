import 'package:flutter/material.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Áo thun',
      description: 'Siêu rẻ',
      price: 70,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
        id: 'p2',
        title: 'Áo khoác',
        description: 'Siêu xịn.',
        price: 199,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg')
  ];
  List<Product> get itemsFavorite {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  // void addProductItem() {
  //   notifyListeners();
  // }
}
