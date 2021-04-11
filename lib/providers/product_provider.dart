import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get itemsFavorite {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  final String authToken;
  ProductsProvider(this.authToken, this._items);
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProductItem(Product product) async {
    const url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products.json?';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'id': product.id,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetAndSetProducts() async {
    final url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            title: prodData['title'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'imageUrl': product.imageUrl,
            'description': product.description,
            'price': product.price,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProducItem(String id) async {
    final url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    final response = await http.delete(Uri.parse(url));
    _items.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Không thể xóa sản phẩm');
    }
    existingProduct = null;
  }
}
