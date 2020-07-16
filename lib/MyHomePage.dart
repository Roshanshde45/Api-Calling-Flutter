import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/httpService.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Httpservice httpservice = new Httpservice();
  List<dynamic> newsList = [];
  bool dataGathered = false;

  @override
  void initState() {
    super.initState();
    getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Today's News"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.widgets),
              onPressed: () async {
                await httpservice.getNews();
              },
            )
          ],
        ),
        body: dataGathered
            ? showListOfNews(context)
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  getAllNews() async {
    List<dynamic> newsListWow = [];
    newsListWow = await httpservice.getNews();
    setState(() {
      newsList = newsListWow;
      dataGathered = true;
    });
    print(
        "::::::::::::::::::::::::::::::::::::::::::::::::::::::::: newsList :::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    print(newsListWow);
  }

  Widget showListOfNews(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Image.network(
                      newsList[index]["urlToImage"],
                      height: 220,
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          newsList[index]["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        newsList[index]["description"],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, int i) {
          return Container(
            height: 1,
            color: Colors.grey[100],
          );
        },
        itemCount: newsList.length);
  }
}
