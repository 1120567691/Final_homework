import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

//新闻详情
class Detail extends StatefulWidget {
  var news;

  Detail({required this.news});

  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<Detail> {
  var news;
  late dom.Document document;

  @override
  void initState() {
    super.initState();
    //获取传入的数据
    news = widget.news;

    //设置html数据
    document = htmlparser.parse(news['content']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          primary: true,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            '详情',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          actions: [],
        ),
        body: Html(
          data: news['content'],
        ));
  }
}
