import 'package:dio/dio.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  String applicationJson = "application/json";
  String contentType = "content-type";
  String accept = "accept";
  String authorization = "authorization";
  String defaultLanguage = "en";
  final AppPreferences _appPreference;

  DioFactory(this._appPreference);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreference.getAppLanguage();
    String token = _appPreference.getToken();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: token,
      defaultLanguage: language
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseurl,
        headers: headers,
        receiveTimeout: Constant.timeout,
        sendTimeout: Constant.timeout);

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}