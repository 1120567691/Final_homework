import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'Detail.dart';

//首页
class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homeState();
  }
}

class homeState extends State<home> {
  var httpClient = new HttpClient(); //http请求
  TextEditingController controller = TextEditingController(); //输入框
  List list = []; //数据列表

  //获取新闻列表
  _getData(String type) async {
    list.clear();
    var url =
        'https://api.jisuapi.com/news/get?channel=$type&start=0&num=20&appkey=f703f0916b243386';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        print('result:${data}');
        setState(() {
          list.addAll(data['result']['list']);
        });
      }
    } catch (exception) {
      print('exception:$exception');
      result = 'Failed getting data';
    }
  }

  @override
  void initState() {
    super.initState();
    _getData('头条');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Image.asset(
                      'images/img.png',
                      width: 50,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'demo',
                          style: TextStyle(fontSize: 28),
                        )),
                  )
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _getData('头条');
                          },
                          child: Container(
                            height: 40,
                            color: Colors.blue,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '头条',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _getData('财经');
                          },
                          child: Container(
                            height: 40,
                            color: Colors.blue,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            child: Text(
                              '财经',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _getData('体育');
                          },
                          child: Container(
                            height: 40,
                            color: Colors.blue,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            child: Text(
                              '体育',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _getData('教育');
                          },
                          child: Container(
                            height: 40,
                            color: Colors.blue,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            child: Text(
                              '教育',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )))
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 500,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return buildItem(index);
                    }),
              )
            ],
          ))),
    );
  }

//绘制子项
  buildItem(index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(news: list[index])));
        },
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
          width: MediaQuery.of(context).size.width,
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        '${list[index]['title']}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                  SizedBox(height: 20),
                  Text(
                    '${list[index]['time']}',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ],
              ),
              Image.network(
                '${list[index]['pic']}',
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              )
            ],
          ),
        ));
  }
}
