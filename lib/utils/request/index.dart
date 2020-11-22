import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modal/login.dart';
import '../../config.dart';
import '../../route.dart';

class Request {

  static SharedPreferences prefs;

  static Dio httpRequest = new Dio();

  static String token;

  Request() {
    init();
  }

  static _getDbToken() async {
    prefs = await SharedPreferences.getInstance();
    final String tokenStr = prefs.getString('token');
    if (tokenStr != null) {
      token = tokenStr;
      initRequestToken();
      return tokenStr;
    }
    return null;
  }

  static _setUserInfo(String user, String name) async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    prefs.setString('user', user);
    prefs.setString('name', name);
  }

  static initRequestToken() {
    httpRequest.interceptors.add(InterceptorsWrapper(
      onRequest: (Options options) async {
        options.headers["token"] = token;
        return options;
      }
    ));
  }

  static _setDbToken(String value) async {
    if (value == null) {
      return false;
    }
    token = value;
    initRequestToken();
    prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString('token', value);
    return res;
  }

  static clearToken() async {
    prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString('token', '');
    return res;
  }

  static init() async {
    // 验证之前是否有token。
    final String tokenStr = await _getDbToken();
    if (tokenStr == null) {
      return false;
    }
    // 远程验证token是否过期切替换token
    bool res = await validate();
    return res;
  }

  static validate () async {
    try {
      if (prefs == null) {
        prefs = await SharedPreferences.getInstance();
      }
      final String user = prefs.getString('user');
      if (user == null) {
        return false;
      }
      final Response response = await httpRequest.post(
        Urls.env + '/validate'
      );
      if (response.data != null && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print(e);
      return false;
    }
    
  }

  static login (String url, Map<String, dynamic> params) async {
    try {
      Response response = await httpRequest.post(
        url,
        data: params
      );
      if (response.data != null && response.data['success'] == true) {
        final List<String> tokens = response.headers['token'];
        _setDbToken(tokens[0]);
        _setUserInfo(response.data['data']['user'], response.data['data']['name']);
        return response.data;
      } else {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }
  

  static post (String url, Map<String, dynamic> params) async {
    print(LoginModal);
    try {
      Response response = await httpRequest.post(
        url,
        data: params
      );
      if (response.data['code'] == 2) {
        GloabalRouter.navigatorKey.currentState.pushNamedAndRemoveUntil("/redictLogin", ModalRoute.withName("/"));
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
