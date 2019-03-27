import "package:flutter/material.dart";
import "../model/categoryGoodList.dart";

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  //点击大类时切换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  //获取更多商品
  getMoreList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
