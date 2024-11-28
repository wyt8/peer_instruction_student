import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peer_instruction_student/common/global.dart';
import 'package:toastification/toastification.dart';

enum RequestMethod { get, post, put, delete, patch, head }

class BaseRequest {
  // 单例模型
  static BaseRequest? _instance;

  factory BaseRequest() => _instance ?? BaseRequest._internal();

  static BaseRequest get instance => _instance ?? BaseRequest._internal();

  static Dio _dio = Dio();

  static const String _baseUrl =
      "http://116.205.181.81:8081";

  BaseRequest._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    _dio = Dio(options);
    _instance = this;

    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Global.isLogin) {
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer ${Global.user.token}";
    }
    handler.next(options);
  }

  /// 响应拦截器
  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  /// 错误处理
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    toastification.show(
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      title: const Text('网络连接错误'),
      type: ToastificationType.error,
    );
    // handler.next(error);
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前调用该方法
  void openLog(
      {bool request = true,
      bool requestHeader = true,
      bool requestBody = false,
      bool responseHeader = true,
      bool responseBody = false,
      bool error = true}) {
    _dio.interceptors.add(LogInterceptor(
        request: request,
        requestHeader: requestHeader,
        requestBody: requestBody,
        responseHeader: responseHeader,
        responseBody: responseBody));
  }

  /// 请求方法封装
  Future<T> request<T>(
    String path, {
    String? baseUrl,
    RequestMethod method = RequestMethod.get,
    Map<String, dynamic>? queryParameters,
    Object? data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const methodValues = {
      RequestMethod.get: 'GET',
      RequestMethod.post: 'POST',
      RequestMethod.put: 'PUT',
      RequestMethod.delete: 'DELETE',
      RequestMethod.patch: 'PATCH',
      RequestMethod.head: 'HEAD'
    };
    options ??= Options();
    options.method = methodValues[method];
    String url;
    if (baseUrl == null) {
      url = path;
    } else {
      url = baseUrl + path;
    }
    openLog(requestBody: true, responseBody: true);
    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    return response.data;
  }
}
