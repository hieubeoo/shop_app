import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_by_category_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/tab_screen.dart';
import 'package:shop_app/screens/waiting_screen.dart';
import './providers/product_provider.dart';
import './providers/orders.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          update: (
            ctx,
            authData,
            previousProduct,
          ) =>
              ProductsProvider(
            authData.token,
            authData.userId,
            previousProduct == null ? [] : previousProduct.items,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, authData, previousOrder) => Orders(
              previousOrder == null ? [] : previousOrder.orders,
              authData.token,
              authData.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth
              ? TabsScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? WaitingScreen()
                          : AuthScreen(),
                  future: authData.tryAutoLogin(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            ProductsByCategory.routeName: (ctx) => ProductsByCategory(),
          },
        ),
      ),
    );
  }
}
