import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider.dart';

///hooks_riverpod 導入
///StatelessWidgetの代わりにHookConsumerWidgetをextendsする。
///(riverpodのみの場合はConsumerWidgetをextendsする）
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///WidgetRefを使用してproviderを呼び出す。
    ///ref.watchとref.readがある。
    ///watchで宣言した場合、providerの値が変更されるたびに再評価される。
    final username = ref.watch(usernameProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ログイン"),
      ),
      body: Padding(
        ///画面の左右に30の余白をとる。
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          ///ウィジェット時の配置を指定している
          ///spaceEvenly = 上下余白とウィジェット間の距離を同じくとる。
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///ユーザーネーム 入力フォーム
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ユーザーネーム',
              ),

              ///テキストフィールドの値が変化した時に呼び出される。
              ///valueに入力されたテキストが入ってる(String)
              onChanged: (value) {
                ///stateProviderの値を直接変更してる。
                ref.read(usernameProvider.notifier).state = value;
              },
            ),

            ///ログインボタン
            ElevatedButton(

                ///ボタン押下時のイベント
                onPressed: () => Navigator.pushNamed(context, '/itemList'),

                ///背景色を指定
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),

                ///ボタンの中に表示するテキスト
                child: const Text(
                  "ログイン",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
