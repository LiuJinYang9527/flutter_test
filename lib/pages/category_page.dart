import 'package:flutter/material.dart';
import "../service/service_method.dart";
import "../config/service_url.dart";
import "dart:convert";

class CategoryPage extends StatefulWidget {

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text('分类页面'),
       ),
    );
  }
  void _getCategory() async {
    await reqeust('getCategory').then((res){
      var data= json.decode(res.toString());
      print(data);
    });
  }
}