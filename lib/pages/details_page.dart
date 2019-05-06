import "package:flutter/material.dart";
import "package:provide/provide.dart";
import "../provide/details_info.dart";
import "./detailPages/details_top_area.dart";
import "./detailPages/detail_explain.dart";
import "./detailPages/details_tabbar.dart";

class DetailsPage extends StatelessWidget {
  String goodsId = '0';
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('商品详细页'),
        ),
        body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView(
                children: <Widget>[
                  DetailTopArea(),
                  DetailsExplain(),
                  DetailsTabBar()
                ],
              ));
            } else {
              return Text('加载中。。。');
            }
          },
        ));
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
