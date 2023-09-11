import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/storage/secure_storage.dart';
import 'package:winter_foodies/user/provider/auth_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.ref,
    required this.storage,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    // final isStatus500 = handler.response?.statusCode == 500;
    //
    // if(isStatus500){
    //   return null;
    // }

    // if (options.headers['refreshToken'] == 'true') {
    //   options.headers.remove('refreshToken');
    //   final token = await storage.read(key: REFRESH_TOKEN_KEY);
    //   //실제 토근으로 대체
    //   options.headers.addAll({
    //     'authorization': 'Bearer $token',
    //   });
    // }

    return super.onRequest(options, handler);
  }

// 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    print('Data: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러 났을때(토큰 만료, 토큰 오타, status code)
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //
    // //refreshToken 아예 없으면 당연히 에러 던진다
    if (accessToken == null) {
      //에러 던질때는 reject 사용
      print('accessNull?');
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401; //401
    final isPathRefresh = err.requestOptions.path == '/auth/token';
    final isStatus500 = err.response?.statusCode == 500; // 추가: 500 에러 체크


    if(isStatus500){
      ref.read(authProvider.notifier).logout();
      return null;
    }

    print('Hallo');
    return handler.reject(err);
  }
}
