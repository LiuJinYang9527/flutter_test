import "package:flutter/material.dart";
import "./pages/index_page.dart";
import "package:provide/provide.dart";
import "./provide/counter.dart";
import "./provide/child_category.dart";
import "./provide/category_goods_list.dart";
import "./provide/details_info.dart";
import "./provide/cart.dart";
import "./provide/currentIndex.dart";
import "package:fluro/fluro.dart";
import "./router/routers.dart";
import "./router/application.dart";

void main() {
  var counter = new Counter();
  var childCategory = new ChildCategory();
  var categoryGoodsListProvide = new CategoryGoodsListProvide();
  var detailsInfoProvide = new DetailsInfoProvide();
  var cartProvide = new CartProvide();
  var currentIndexProvide = new CurrentIndexPrvide();
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexPrvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //fluro 初始化
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
        child: (MaterialApp(
            title: 'test',
            onGenerateRoute: Application.router.generator,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.pink),
            home: IndexPage())));
  }
}
