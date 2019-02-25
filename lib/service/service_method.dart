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
        ContentType.parse("applicaiton/x-www-form-urlencode");
    var formData = {"lon": "113.6313915479", "lat": "34.7533581487"};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      var data = json.decode(response.data.toString());
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
