import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/repository/main_repository.dart';

class MainDataTestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainRepository = ref.watch(mainRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Main Data Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final response = await mainRepository.fetchMainData(
                  latitude: 37.381798,  // 예제 위도
                  longitude: 126.800944 // 예제 경도
              );
              print(response); // 콘솔에서 응답 확인
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data Fetched!")),
              );
            } catch (e) {
              print(e); // 에러 출력
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: $e")),
              );
            }
          },
          child: Text("Fetch Main Data"),
        ),
      ),
    );
  }
}
