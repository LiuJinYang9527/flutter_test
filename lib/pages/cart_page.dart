import "package:flutter/material.dart";
import "package:provide/provide.dart";
import "../provide/counter.dart";
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: <Widget>[
        Number(),
        MyButton()
      ],
    )));
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: 80),
      child: Provide<Counter>(
        builder: (context,child,counter){
          return Text('${counter.value1}',style: Theme.of(context).textTheme.display1);
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('自增'),
      ),
    );
  }
}
