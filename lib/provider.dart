import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'vegetable.dart';

///usernameの入力を保持するプロバイダーを定義する。
///ここで使うのはStateProvider、簡単な値を保持するために使われる。
///他のProviderは↓参照
///https://docs-v2.riverpod.dev/docs/concepts/providers#different-types-of-providers
///String型を保持し、初期値は""で定義してる。
final usernameProvider = StateProvider<String>((ref) => "");

///カートアイテムを保持するプロバイダー。
///ここで管理するのはList<Vegetable>という単純じゃない値なので、StateNotifierProviderを使用する。
///.autoDisposeを付けることで、参照されなくなった際に破棄されるようになる
final cartItemProvider =
    StateNotifierProvider.autoDispose<CartItemNotifier, List<Vegetable>>((ref) {
  return CartItemNotifier();
});

///↑のcartItemProviderで使われるStateNotifier
///ここで関数を定義することで、管理が簡単になる。
///！！注意！！StateNotifierで扱う値はimmutableである
class CartItemNotifier extends StateNotifier<List<Vegetable>> {
  ///初期値 []
  CartItemNotifier() : super([]);

  ///リストに野菜を追加するメソッド
  void add(Vegetable vegetable) {
    ///stateはimmutableである
    ///つまりstate.add(vegetable)が出来ない
    ///なのでstateにvegetableを追加した新しい値で更新する。
    state = [...state, vegetable];
  }

  ///引数の野菜をリストから削除するメソッド
  void remove(Vegetable vegetable) {
    ///こちらも同じ
    ///state.remove(vegetable)が出来ない
    ///なのでstateからvegetableを削除した新しい値で更新する。
    state = List<Vegetable>.from(state)..remove(vegetable);
  }
}
