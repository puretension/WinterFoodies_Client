import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:winter_foodies/common/model/main_page_model.dart';

part 'main_repository.g.dart';

final mainRepositoryProvider = Provider<MainRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return MainRepository(dio, baseUrl: 'http://$ip/api/main');
  },
);

@RestApi()
abstract class MainRepository {
  factory MainRepository(Dio dio, {String? baseUrl}) = _MainRepository;

  @GET('/')
  Future<MainPageModel> fetchMainData({
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
  });
}
