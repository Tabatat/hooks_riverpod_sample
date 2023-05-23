import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod_sample/screen/cart_list_screen.dart';
import 'package:hooks_riverpod_sample/screen/item_list_screen.dart';

import 'screen/login_screen.dart';

void main() {
  runApp(

      ///riverpod導入の第一段階
      ///MyApp()をProviderScopeでラップする
      const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hooks_riverpod Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/itemList': (context) => const ItemListScreen(),
        '/cartItem': (context) => const CartItemScreen(),
      },
    );
  }
}
