import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



void main() {
  runApp(
    ///riverpod導入の第一段階
    ///MyApp()をProviderScopeでラップする
      const ProviderScope(child: MyApp())
  );
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
        '/':(context) => const LoginScreen(),
      },
    );
  }
}

///hooks_riverpod 導入
///StatelessWidgetの代わりにHookConsumerWidgetをextendする。
///(riverpodのみの場合はConsumerWidgetをextendsする）
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ログイン"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ユーザーネーム',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  print("");
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 30),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: const Text("ログイン")),
          ],
        ),
      ),
    );
  }
}
