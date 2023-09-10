import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/storage/secure_storage.dart';

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

    // final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    //
    // //refreshToken 아예 없으면 당연히 에러 던진다
    // if (refreshToken == null) {
    //   //에러 던질때는 reject 사용
    //   print('refreshNull?');
    //   return handler.reject(err);
    // }

    final isStatus401 = err.response?.statusCode == 401; //401
    final isPathRefresh = err.requestOptions.path == '/auth/token';
    final isStatus500 = err.response?.statusCode == 500; // 추가: 500 에러 체크

    // //토큰을 refresh하려는 의도가 아니었는데 403에러가 났다면?
    // if ((isStatus401 && !isPathRefresh)) {
    //   final dio = Dio();
    //   try {
    //     final resp = await dio.post(
    //       'http://$ip/api/auth/token', //수정
    //       options: Options(
    //         headers: {
    //           'authorization': 'Bearer $refreshToken',
    //         },
    //       ),
    //     );
    //     final accessToken = resp.data['accessToken'];
    //
    //     print('please$accessToken');
    //
    //     final options = err.requestOptions;
    //
    //     //토큰 변경하기
    //     options.headers.addAll({
    //       'authorization': 'Bearer $accessToken',
    //     });
    //
    //     print('테스트용: ${accessToken}');
    //     //storage 업데이트 당연히 필요
    //     await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    //
    //     final response = await dio.fetch(options);
    //
    //     return handler.resolve(response);
    //   } on DioError catch (e) {
    //     print('DioError Occurred: ${e.message}');
    //
    //     // ref.read(authProvider.notifier).logout(); //아직구현X
    //     return handler.reject(err);
    //   }
    // } else if (isStatus500) {
    //   print('state is 500?');
    //   return null;
    // }
    print('Hallo');
    return handler.reject(err);
  }
}
