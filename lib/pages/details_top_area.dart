import "package:flutter/material.dart";
import "package:provide/provide.dart";
import "../provide/details_info.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo =
            Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.oriPrice, goodsInfo.presentPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载。。。');
        }
      },
    );
  }

//顶部商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(750),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(name, style: TextStyle(fontSize: ScreenUtil().setSp(30))),
    );
  }

  //商品编号
  Widget _goodsNum(id) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text('id:${id}',
          style: TextStyle(
              color: Colors.black12, fontSize: ScreenUtil().setSp(26))),
    );
  }

  //price
  Widget _goodsPrice(double originPrice, double salesPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 20.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text('售价:${salesPrice}',
              style: TextStyle(
                  color: Colors.red, fontSize: ScreenUtil().setSp(26))),
          Container(
            margin: EdgeInsets.only(left: 100.0),
            child: Text('原价:${originPrice}',
                style: TextStyle(
                    color: Colors.black12,
                    decoration: TextDecoration.lineThrough,
                    fontSize: ScreenUtil().setSp(26))),
          )
        ],
      ),
    );
  }
}
