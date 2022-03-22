import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capyba/models/auth.dart';
import 'package:capyba/models/cart.dart';
import 'package:capyba/models/order_list.dart';
import 'package:capyba/models/product_list.dart';
import 'package:capyba/pages/auth_or_home_page.dart';
import 'package:capyba/pages/cart_page.dart';
import 'package:capyba/pages/orders_page.dart';
import 'package:capyba/pages/product_detail_page.dart';
import 'package:capyba/pages/product_form_page.dart';
import 'package:capyba/pages/products_page.dart';
import 'package:capyba/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: 'Lato');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
                primary: Colors.green,
                secondary: Colors.blue[400],
                tertiary: Colors.white)),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
