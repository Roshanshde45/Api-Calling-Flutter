import 'dart:convert';
import 'package:http/http.dart';
import 'dart:async';
import 'package:newsapp/model.dart';
class Httpservice {
  final String url = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-05-24&sortBy=publishedAt&apiKey=82e6528d118a4613ab4ff12f8d2c4320";

  Future<List<dynamic>> getNews() async{
    Response res = await get(url);
    print("failed see ::::::::::::::::::::::");
    if(res.statusCode == 200) {
//      print("Error 1:");
      Map<String,dynamic> body = jsonDecode(res.body);
//      print(body["articles"]);
      List<dynamic> data = body["articles"];
      print("::::::::::::::::::::now see::::::::::::::::::");
//      print(data);
      return data;
    }else {
      throw "Error while fetching News Stream";
    }
  }

}