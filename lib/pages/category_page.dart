import 'package:flutter/material.dart';
import "../service/service_method.dart";
import "dart:convert";
import "../model/category.dart";
import "../model/categoryGoodList.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provide/provide.dart";
import "../provide/child_category.dart";
import "../provide/category_goods_list.dart";

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分類')),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNavState(),
            Column(
              children: <Widget>[_RightCategory(), CategoryGoodList()],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNavState extends StatefulWidget {
  _LeftCategoryNavStateState createState() => _LeftCategoryNavStateState();
}

class _LeftCategoryNavStateState extends State<LeftCategoryNavState> {
  List list = [];
  int ListIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == ListIndex) ? true : false;
    return InkWell(
      onTap: () {
        var childList = list[index].bxMallSubDto;
        setState(() {
          ListIndex = index;
        });
        var cateGoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getGoodsList(categoryId: cateGoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        decoration: BoxDecoration(
          color: isClick ? Colors.black12 : Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: Text(list[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ),
    );
  }

  void _getCategory() async {
    await reqeust('getCategory').then((res) {
      var data = json.decode(res.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
        Provide.value<ChildCategory>(context)
            .getChildCategory(list[ListIndex].bxMallSubDto);
      });
      // list.data.forEach((item){
      //   print(item.mallCategoryName);
      // });
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      "categoryId": categoryId == null ? '4' : categoryId,
      "CategorySubId": '',
      "page": 1,
    };
    await reqeust('getMallGoods', formData: data).then((res) {
      var data = json.decode(res.toString());
      CategoryGoodListModel goodData = CategoryGoodListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodData.data);
    });
  }
}

//右侧横向滚动导航
class _RightCategory extends StatefulWidget {
  __RightCategoryState createState() => __RightCategoryState();
}

class __RightCategoryState extends State<_RightCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setWidth(570),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkell(childCategory.childCategoryList[index]);
            }),
      );
    });
  }

  Widget _rightInkell(BxMallSubDto item) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Text(item.mallSubName,
              style: TextStyle(fontSize: ScreenUtil().setSp(28))),
        ));
  }
}

//分类商品列表
class CategoryGoodList extends StatefulWidget {
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data) {
      return Expanded(
        child: Container(
          width: ScreenUtil().setWidth(570),
          child: ListView.builder(
              itemCount: data.goodsList.length,
              itemBuilder: (BuildContext context, int index) {
                return _ListItemWidget(data.goodsList, index);
              }),
        ),
      );
    });
  }

  //图片组件
  Widget _goodsImage(list, index) {
    return Container(
        width: ScreenUtil().setWidth(200),
        child: Image.network(list[index].image));
  }

  //商品名称组件
  Widget _goodsName(list, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        '${list[index].goodsName}',
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  //商品价格组件
  Widget _goodsPrice(list, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Text('价格:￥${list[index].presentPrice}',
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(30))),
          Text('￥${list[index].oriPrice}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough)),
        ],
      ),
    );
  }

  //商品详情组件
  Widget _ListItemWidget(list, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            Expanded(child: _goodsImage(list, index)),
            Column(children: <Widget>[
              _goodsName(list, index),
              _goodsPrice(list, index)
            ])
          ],
        ),
      ),
    );
  }
}
