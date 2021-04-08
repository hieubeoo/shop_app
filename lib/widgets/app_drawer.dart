import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[600], Colors.blue[200]],
              ),
            ),
            child: Text(
              'Shop',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Cửa hàng',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Order',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Quản lý sản phẩm của bạn',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
