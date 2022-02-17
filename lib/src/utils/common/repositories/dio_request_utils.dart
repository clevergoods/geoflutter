import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/data/common/routes/remote_routes.dart';
import 'package:dio/dio.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../system_log/flogger.dart';

class DioRequestUtils {
  late Dio _dio;
  Flogger get logger => GetIt.instance.get<Flogger>();

  static DioRequestUtils get instance => _instance;
  static final DioRequestUtils _instance = DioRequestUtils._();
  DioRequestUtils._() {
    _dio = Dio();
    var options = BaseOptions(
        baseUrl: RemoteRoutes.wlUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.bytes,
        headers: <String, String>{
          'Cookie': 'lang=RU',
        });
    _dio = Dio(options);

    var cookieJar=CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    cookieJar.loadForRequest(Uri.parse(RemoteRoutes.wlUrl));
  }

  Future<Map<String, dynamic>> jsonRequest (
      Map<String, dynamic> json, String requestUrl) async {
    var requestJson = jsonEncode(json);
    var response = await _dio.post(requestUrl, data: requestJson);
    var answer = jsonDecode(utf8.decode(response.data));
    return answer;
  }

  closeClient(){
    _dio.close();
  }
}
