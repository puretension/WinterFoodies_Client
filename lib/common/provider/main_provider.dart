import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/model/main_page_model.dart';
import 'package:winter_foodies/common/repository/main_repository.dart';


class MainPageState {
  final MainPageModel? mainData;
  final bool isLoading;

  MainPageState({this.mainData, this.isLoading = false});
}

final mainPageNotifierProvider = StateNotifierProvider<MainPageNotifier, MainPageState>(
      (ref) {
    final repository = ref.watch(mainRepositoryProvider);
    return MainPageNotifier(repository);
  },
);

class MainPageNotifier extends StateNotifier<MainPageState> {
  final MainRepository repository;

  MainPageNotifier(this.repository) : super(MainPageState()){
    fetchMainData(37.381798,126.800944);
  }

  fetchMainData(double? latitude, double? longitude) async {
    state = MainPageState(isLoading: true);
    try {
      final data = await repository.fetchMainData(latitude: latitude, longitude: longitude);
      state = MainPageState(mainData: data, isLoading: false);
    } catch (e) {
      state = MainPageState(isLoading: false);
      // 여기서 에러 핸들링을 할 수 있습니다.
    }
  }
}
