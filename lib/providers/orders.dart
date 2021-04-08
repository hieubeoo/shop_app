import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.amount,
    @required this.dateTime,
    @required this.id,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _oders = [];
  List<OrderItem> get orders {
    return [..._oders];
  }

  Future<void> fetAndSetOrder() async {
    const url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(
              orderData['dateTime'],
            ),
            products: (orderData['products'] as List<dynamic>)
                .map((prod) => CartItem(
                      id: prod['id'],
                      price: prod['price'],
                      quantity: prod['quantity'],
                      title: prod['title'],
                    ))
                .toList()),
      );
    });

    _oders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    const url =
        'https://aquarium-shop-b8c06-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProduct
            .map((cart) => {
                  'id': cart.id,
                  'title': cart.title,
                  'quantity': cart.quantity,
                  'price': cart.price,
                })
            .toList(),
      }),
    );
    _oders.insert(
      0,
      OrderItem(
        amount: total,
        dateTime: timestamp,
        id: json.decode(response.body)['name'],
        products: cartProduct,
      ),
    );
    notifyListeners();
  }
}
