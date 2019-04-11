import "package:flutter/material.dart";

class DetailsPage  extends StatelessWidget {
  String goodsId = '0';
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品ID:${goodsId}')
      ),
    );
  }
}