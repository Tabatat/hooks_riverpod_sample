import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider.dart';
import '../vegetable.dart';

class CartItemScreen extends HookConsumerWidget {
  const CartItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///usernameとcartをproviderから取得
    final username = ref.watch(usernameProvider);
    final cart = ref.watch(cartItemProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("$usernameのカート"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        ///野菜を一覧で表示する
        body: ListView(
          children: items
              .map((vegetable) => ListTile(
                    title: Text(vegetable.name),
                    subtitle: Text("カート内の個数:"
                        "${cart.count(vegetable)}"),
                    trailing: Text(
                      "合計金額:${vegetable.price * cart.count(vegetable)}円",
                      style: const TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      ///CartItemNotifierのremoveメソッドを呼んで削除している。
                      ref.read(cartItemProvider.notifier).remove(vegetable);
                    },
                  ))
              .toList(),
        ));
  }
}
