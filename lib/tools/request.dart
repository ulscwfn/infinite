import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

export 'package:dio/dio.dart'
    show Response, RequestOptions, DioError, DioErrorType;

/// dio 请求封装；
abstract class Request {
  /// 基础路径地址
  String baseUrl = '';
  int connectTimeout = 6000;
  int receiveTimeout = 6000;

  /// 错误拦截
  @protected
  DioError onError(DioError error) => error;

  /// 请求结果拦截
  @protected
  Response<dynamic> onResponse(Response<dynamic> response) => response;

  /// 请求拦截
  @protected
  Future<RequestOptions> onRequest(RequestOptions options) async => options;

  @protected
  Dio get _request {
    Dio instance = Dio();
    instance.options = BaseOptions(
      baseUrl: this.baseUrl,
      connectTimeout: this.connectTimeout,
      receiveTimeout: this.receiveTimeout,
    );
    instance.interceptors.add(
      InterceptorsWrapper(
        onError: this.onError,
        onRequest: this.onRequest,
        onResponse: this.onResponse,
      ),
    );
    return instance;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> data,
    bool authorized = true,
  }) {
    return this._request.get<T>(
          path,
          queryParameters: data,
          options: Options(headers: {'authorized': authorized}),
        );
  }

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic> data,
    bool authorized = true,
  }) {
    return this._request.post<T>(
          path,
          data: data,
          options: Options(headers: {'authorized': authorized}),
        );
  }
}
