import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:onlymessage/app/core/rest_client/interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  late final AuthInterceptor _authInterceptor;

  CustomDio()
      : super(BaseOptions(
          baseUrl: 'http://10.0.2.2:3001',
          connectTimeout: 5000,
          receiveTimeout: 60000,
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
    _authInterceptor = AuthInterceptor();
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
