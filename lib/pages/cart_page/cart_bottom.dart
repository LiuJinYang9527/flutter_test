import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[_selectAllBtn(), _allPriceArea(), _confirmBtn()],
      ),
    );
  }

  Widget _selectAllBtn() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计:',
                  style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                ),
                width: ScreenUtil().setWidth(280),
              ),
              Container(
                width: ScreenUtil().setWidth(150),
                alignment: Alignment.centerLeft,
                child: Text('￥1515', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            child: Text('满10元免配送费,预购免配送费',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(22))),
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }

  Widget _confirmBtn() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text('结算',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(26))),
        ),
      ),
    );
  }
}
