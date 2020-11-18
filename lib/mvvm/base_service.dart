import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin BaseService {
  /// 基础路径地址
  String get baseUrl;

  /// 连接超时/毫秒
  int get connectTimeout;

  /// 返回超时/毫秒
  int get receiveTimeout;

  /// 错误拦截
  @protected
  DioError onError(DioError error);

  /// 请求结果拦截
  @protected
  Response<dynamic> onResponse(Response<dynamic> response);

  /// 请求拦截
  @protected
  Future<RequestOptions> onRequest(RequestOptions options);

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
