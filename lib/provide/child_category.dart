import "package:flutter/material.dart";
import "../model/category.dart";

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; // 大类ID
  String subId = ''; //小类id
  int page = 1; //列表页数
  String noMoreText = ''; //显示没有数据的文字
  //大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
