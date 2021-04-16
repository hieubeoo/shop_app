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

  final String userId;
  final String authToken;
  ProductsProvider(this.authToken, this.userId, this._items);
  List<Product> get items {
    return [..._items];
  }

  List<Product> productByCategory(String category) {
    return [..._items.where((prod) => prod.category == category)].toList();
  }

  List<Product> searchProduct(String text) {
    if (text.isEmpty) {
      return [..._items];
    }
    return [..._items.where((prod) => prod.title.contains(text))].toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addProductItem(Product product) async {
    final url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'id': product.id,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'category': product.category,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
        category: product.category,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetAndSetProducts() async {
    var url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      url =
          'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken';

      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            title: prodData['title'],
            category: prodData['category'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false));
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
          'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
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
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
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
