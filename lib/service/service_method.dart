import "package:dio/dio.dart";
import "dart:async";
import "dart:io";
import "../config/service_url.dart";
import "dart:convert";

//获取首页主题内容

Future getHomePageContent() async {
  try {
    print('开始获取首页数据。。。');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");

    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      var data = json.decode(response.data.toString());
      print(data);
      if (int.parse(data['code']) != -1) {
        return response.data;
      } else {
        throw Exception('服务器错误');
      }
    } else {
      throw Exception('服务器错误');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}

//获取火爆专区数据
Future getHomePageBeloConten(int page) async {
  try {
    print('开始获取火爆专区数据。。。');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post(servicePath['homePageBelowConten'], data: page);
    if (response.statusCode == 200) {
      var data = json.decode(response.data.toString());
      print(data);
      if (int.parse(data['code']) != -1) {
        return response.data;
      } else {
        throw Exception('服务器错误');
      }
    } else {
      throw Exception('服务器错误');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}

//通用request
Future reqeust(url, formData) async {
  try {
    print('开始获取数据。。。');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      var data = json.decode(response.data.toString());
      print(data);
      if (int.parse(data['code']) != -1) {
        return response.data;
      } else {
        throw Exception('服务器错误');
      }
    } else {
      throw Exception('服务器错误');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}
