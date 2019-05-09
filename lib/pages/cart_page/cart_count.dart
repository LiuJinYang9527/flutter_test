import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provide/provide.dart";
import "../../provide/cart.dart";
import "../../model/cartInfo.dart";

class CartCount extends StatelessWidget {
  var item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _goodNum(context),
          _addBtn(context)
        ],
      ),
    );
  }

  //商品数量
  Widget _goodNum(context) {
    // int count = Provide.value<CartProvide>(context).
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}',
          style:
              TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(24))),
    );
  }

  //减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
        },
        child: Container(
          width: ScreenUtil().setWidth(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: item.count > 1 ? Colors.white : Colors.black12,
              border:
                  Border(right: BorderSide(width: 1, color: Colors.black12))),
          child: item.count > 1 ? Text('-') : Text(''),
        ));
  }

  //增加按钮
  Widget _addBtn(context) {
    return InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
        },
        child: Container(
          width: ScreenUtil().setWidth(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(left: BorderSide(width: 1, color: Colors.black12))),
          child: Text('+'),
        ));
  }
}
