import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import '../screens/product_by_category_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
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
                'My Aquarium',
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
                'Đặt hàng',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(
                'Sản phẩm',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 55),
                ),
                child: Text(
                  'Máy lọc, vật liệu lọc',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'filterAndMaterial',
                      'title': 'Máy lọc, vật liệu lọc',
                    },
                  );
                }),
            TextButton(
                child: Text('Máy sủi Oxy, Bơm, Máy sưởi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'oxygenMachine',
                      'title': 'Máy sủi Oxy, Bơm, Máy sưởi',
                    },
                  );
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 10),
                ),
                child: Text('Phân nền, cốt nền thủy sinh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'fertilizer',
                      'title': 'Phân nền, cốt nền thủy sinh',
                    },
                  );
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 100),
                ),
                child: Text('Đèn thủy sinh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'light',
                      'title': 'Đèn thủy sinh',
                    },
                  );
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 65),
                ),
                child: Text('Thức ăn cho cá tép',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'foodShrimp',
                      'title': 'Thức ăn cho cá tép',
                    },
                  );
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 100),
                ),
                child: Text('Cây thủy sinh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'tree',
                      'title': 'Cây thủy sinh',
                    },
                  );
                }),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(right: 100),
                ),
                child: Text('Cá, Tép cảnh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductsByCategory.routeName,
                    arguments: {
                      'category': 'fishAndShrimp',
                      'title': 'Cá, Tép cảnh',
                    },
                  );
                }),
            Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
