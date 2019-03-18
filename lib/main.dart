import "package:flutter/material.dart";
import "./pages/index_page.dart";
import "package:provide/provide.dart";
import "./provide/counter.dart";
import "./provide/child_category.dart";
void main() {
  var counter = new Counter();
  var childCategory = new ChildCategory();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter))..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(child: MyApp(),providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: (MaterialApp(
            title: 'test',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.pink),
            home: IndexPage())));
  }
}
