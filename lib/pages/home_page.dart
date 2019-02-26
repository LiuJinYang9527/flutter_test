import "package:flutter/material.dart";
import "../service/service_method.dart";
import "package:flutter_swiper/flutter_swiper.dart";
import "dart:convert";
import "package:flutter_screenutil/flutter_screenutil.dart";

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  // @override
  // void initState() {
  //   getHomePageContent().then((res){
  //     setState(() {
  //      homePageContent = res.toString();
  //     });
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Melon'),
          ),
          body: FutureBuilder(
            future: getHomePageContent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = json.decode(snapshot.data.toString());
                List<Map> swiper = (data['data']['slides'] as List).cast();
                return Column(
                  children: <Widget>[SwiperDiy(swiperDataList: swiper)],
                );
              } else {
                return Center(child: Text('加载中。。。'));
              }
            },
          )),
    );
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备像素密度${ScreenUtil.pixelRatio}');
    print('设备的高${ScreenUtil.screenHeight}');
    print('设备的宽${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
