import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../provider.dart';

///hooks_riverpod 導入
///StatelessWidgetの代わりにHookConsumerWidgetをextendsする。
///(riverpodのみの場合はConsumerWidgetをextendsする）
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///TextFieldに挿すcontroller
    ///hooksが提供しているuseTextEditingControllerを使う
    final controller = useTextEditingController();

    ///ログインボタンのアクティブを管理するuseState
    ///アクティブ状態はわざわざriverpodに切り出すほどでもないが、
    ///管理する必要のある値なのでhookで管理している。(勿論riverpodだけでも同じような実装は出来る)
    final isActive = useState(false);

    ///Reactと同じように使えるuseEffect
    useEffect(() {
      return () {
        ///returnの中に書いた処理はWidgetが破棄される際に呼ばれる。
        ///今回はcontrollerを破棄している。
        controller.dispose();
      };
      ///第二引数を[]にすることで初回のみ呼ばれるようにしている。
    }, []);

    ///入力フォームを変更した際に呼ばれる
    ///ログインボタンのアクティブを切り替える役割
    void handleTextChange(String text) {
      isActive.value = 3 <= text.length;
    }

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
              ///用意したcontrollerを挿す
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ユーザーネーム(3文字以上)',
              ),
              ///テキストフィールドの値が変化した時に呼び出される。
              ///valueに入力されたテキストが入ってる(String)
              onChanged: (value) {
                handleTextChange(value);
              },
            ),

            ///ログインボタン
            ElevatedButton(

                ///ボタン押下時のイベント
                ///isActiveの値を見て切り替えている。
                onPressed: isActive.value ? () {
                  ///stateProviderの値を直接変更してる。
                  ref.read(usernameProvider.notifier).state = controller.text;

                  Navigator.pushNamed(context, '/itemList');
                } : null,

                ///背景色を指定
                style: TextButton.styleFrom(
                  backgroundColor: isActive.value ?
                  Theme.of(context).colorScheme.inversePrimary:
                  Theme.of(context).colorScheme.onBackground,
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
