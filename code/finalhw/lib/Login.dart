import 'dart:ui';

import 'package:demo/ToastUtil.dart';
import 'package:demo/home.dart';
import 'package:flutter/material.dart';

import 'SpTools.dart';

//登录界面
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text(
                '欢迎登录',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(height: 80),
              Container(
                width: 200,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '请输入帐号',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    if (controller.text == null) {
                      ToastUtil.showToast('请输入帐号');
                      return;
                    }
                    //保存帐号
                    SpTools.putString('acount', controller.text);
                    ToastUtil.showToast('登录成功');
                    //跳转到首页
                    Navigator.pushAndRemoveUntil(context,
                        new MaterialPageRoute(builder: (BuildContext c) {
                      return home();
                    }), (r) => false);
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      '登录',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ],
          )),
    );
  }
}
