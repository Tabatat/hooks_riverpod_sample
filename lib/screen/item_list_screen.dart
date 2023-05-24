import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider.dart';
import '../vegetable.dart';

class ItemListScreen extends HookConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///WidgetRefを使用してproviderを呼び出す。
    ///ref.watchとref.readがある。
    ///watchで宣言した場合、providerの値が変更されるたびに再評価される。
    final username = ref.watch(usernameProvider);
    final cart = ref.watch(cartItemProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("$usernameのショッピング"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cartItem');
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),

        ///野菜を一覧で表示する
        body: ListView(
          children: items
              .map((vegetable) => ListTile(
                    title: Text(vegetable.name),
                    subtitle: Text("カート内の個数:"
                        "${cart.count(vegetable)}"),
                    trailing: Text(
                      "単価：${vegetable.price}円",
                      style: const TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      ///CartItemNotifierのaddメソッドを呼んで追加している。
                      ref.read(cartItemProvider.notifier).add(vegetable);
                    },
                  ))
              .toList(),
        ));
  }
}
