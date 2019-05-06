import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provide/provide.dart";
// import "package:flutter_html/flutter_html.dart";
import "../../provide/details_info.dart";
class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodDetails = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    return Container(
      child: Html(
        data:goodDetails
      ),
    );
  }
}