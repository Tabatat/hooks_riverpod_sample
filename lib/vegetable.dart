import 'package:flutter/cupertino.dart';

///野菜クラス
///これのインスタンスをカートに追加したりする。
///StateNotifierの状態はimmutableの必要がある。
@immutable
class Vegetable {
  const Vegetable({
    required this.name,
    required this.price,
  });

  final String name;
  final int price;
}

///引数に指定したvegetableがList<Vegetable>にいくつ入っているか返す
extension VegetableListEx on List<Vegetable> {
  int count(Vegetable vegetable) {
    return where((element) => element == vegetable).length;
  }
}

///商品一覧とカートで使う商品リスト
List<Vegetable> items = [
  const Vegetable(name: "ジャガイモ", price: 79),
  const Vegetable(name: "ニンジン", price: 62),
  const Vegetable(name: "タマネギ", price: 98)
];
