import "package:flutter/material.dart";
import "../service/service_method.dart";
import "package:flutter_swiper/flutter_swiper.dart";
import "dart:convert";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:url_launcher/url_launcher.dart";
import "package:flutter_easyrefresh/easy_refresh.dart";

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerkey =
      new GlobalKey<RefreshFooterState>();
  //保持页面效果
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getHotGoods();
    super.initState();
  }

  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    var formData = {"lon": "113.6313915479", "lat": "34.7533581487"};
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Melon'),
          ),
          body: FutureBuilder(
            future: reqeust('homePageContent', formData: formData),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = json.decode(snapshot.data.toString());
                List<Map> swiper = (data['data']['slides'] as List).cast();
                List<Map> navigatorList =
                    (data['data']['category'] as List).cast();
                String adPicture =
                    data['data']['advertesPicture']['PICTURE_ADDRESS'];
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];
                List<Map> recommnedList =
                    (data['data']['recommend'] as List).cast();
                String floor1Title =
                    data['data']['floor1Pic']['PICTURE_ADDRESS'];
                String floor2Title =
                    data['data']['floor2Pic']['PICTURE_ADDRESS'];
                String floor3Title =
                    data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 = (data['data']['floor1'] as List).cast();
                List<Map> floor2 = (data['data']['floor2'] as List).cast();
                List<Map> floor3 = (data['data']['floor3'] as List).cast();
                //预防页面超出一屏时出现警告 加上singelChildScrollView
                return EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadedText: '上拉加载更多',
                    key: _footerkey,
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 10.0),
                    children: <Widget>[
                      SwiperDiy(swiperDataList: swiper),
                      TopNavigator(navigatorList: navigatorList),
                      AdBanner(adPicture: adPicture),
                      LeaderPhone(
                          leaderImage: leaderImage, leaderPhone: leaderPhone),
                      Recommed(recommendList: recommnedList),
                      FloorTitle(picture_address: floor1Title),
                      FloorContent(floorGoodsList: floor1),
                      FloorTitle(picture_address: floor2Title),
                      FloorContent(floorGoodsList: floor2),
                      FloorTitle(picture_address: floor3Title),
                      FloorContent(floorGoodsList: floor3),
                      // HotGoods()
                      _hotGoods(),
                    ],
                  ),
                  loadMore: () async {
                    print('加载更多');
                    var formData = {'page': page};
                    await reqeust('homePageBelowConten', formData: formData)
                        .then((res) {
                      var data = json.decode(res.toString());
                      List<Map> newGoods = (data['data'] as List).cast();
                      // print(newGoods);
                      setState(() {
                        hotGoodsList.addAll(newGoods);
                        page++;
                      });
                    });
                  },
                );
              } else {
                return Center(child: Text('加载中。。。'));
              }
            },
          )),
    );
  }

  void _getHotGoods() {
    var formData = {'page': page};
    reqeust('homePageBelowConten', formData: formData).then((res) {
      var data = json.decode(res.toString());
      List<Map> newGoods = (data['data'] as List).cast();
      // print(newGoods);
      setState(() {
        hotGoodsList.addAll(newGoods);
        page++;
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
    padding: EdgeInsets.all(5.0),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
                Text('${val['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('￥${val["mallPrice"]}'),
                    Text('￥${val['price']}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      //流式布局
      return Wrap(
          //一行的列数
          spacing: 2,
          children: listWidget);
    } else {
      return Text('暂无数据');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('设备像素密度${ScreenUtil.pixelRatio}');
    // print('设备的高${ScreenUtil.screenHeight}');
    // print('设备的宽${ScreenUtil.screenWidth}');
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

//导航布局
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
        height: ScreenUtil().setHeight(320),
        padding: EdgeInsets.all(3.0),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          padding: EdgeInsets.all(5.0),
          children: navigatorList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList(),
        ));
  }
}

//广告布局
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(adPicture));
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: lauchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void lauchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问';
    }
  }
}

//
class Recommed extends StatelessWidget {
  final List recommendList;

  Recommed({Key key, this.recommendList}) : super(key: key);
  //标题
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: Text('商品推荐', style: TextStyle(color: Colors.pink)));
  }

  //商品项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        // padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey))
          ],
        ),
      ),
    );
  }

  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(363),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ScreenUtil().setHeight(350),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }
}

//楼层标题

class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
        child: Image.network(picture_address));
  }
}

//楼层商品列表

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

// class HotGoods extends StatefulWidget {
//   _HotGoods createState() => _HotGoods();
// }

// class _HotGoods extends State<HotGoods> {
//   @override
//   void initState() {
//     super.initState();
//     reqeust('homePageBelowConten', formData: 1).then((val) {
//       print(val);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('ceshi'),
//     );
//   }
// }
