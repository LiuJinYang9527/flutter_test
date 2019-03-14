import 'package:flutter/material.dart';
import "../service/service_method.dart";
import "../config/service_url.dart";
import "dart:convert";
import "../model/category.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

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
    return Container(
      child: Center(
        child: Text('分类页面'),
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(),
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: Text(list[index].mallCategoryName),
      ),
    );
  }

  void _getCategory() async {
    await reqeust('getCategory').then((res) {
      var data = json.decode(res.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      // list.data.forEach((item){
      //   print(item.mallCategoryName);
      // });
    });
  }
}
