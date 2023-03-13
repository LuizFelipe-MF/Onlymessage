import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_dio.dart';

class AuthInterceptor extends Interceptor {
  final CustomDio dio;

  AuthInterceptor({required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('token');

    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final hasRefreshed = await refreshToken();
      if (hasRefreshed) {
        _retry(err.requestOptions);
      } else {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> refreshToken() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    final refreshToken = sp.getString('refreshToken');

    final res = await dio.unauth().post('/auth/refresh',
        data: {'token': token, 'refreshToken': refreshToken});

    if (res.statusCode == 200) {
      res.data['token'];
      sp.setString('token', res.data['token']);
      sp.setString('refreshToken', res.data['refreshToken']);
      return true;
    }
    return false;
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
