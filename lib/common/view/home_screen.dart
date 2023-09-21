import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/component/custom_text_form_field.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/const/text.dart';
import 'package:winter_foodies/common/model/main_page_model.dart';
import 'package:winter_foodies/common/provider/main_provider.dart';
import 'package:winter_foodies/common/repository/repository_test_screen.dart';
import 'package:winter_foodies/common/view/popular_product_widget.dart';
import 'package:winter_foodies/common/view/splash_screen.dart';
import 'package:winter_foodies/location/provider/location_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? address;
  final VoidCallback onRefresh;

  const HomeScreen({Key? key, this.address, required this.onRefresh})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentPopularProductIndex = 0;
  late TextEditingController searchController;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    controller = ScrollController();
  }

  @override
  void dispose() {
    searchController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final state = ref.watch(mainPageNotifierProvider);
    final locationState = ref.watch(locationProvider);

    if (state is! MainPageState || locationState.address == null) {
      return SplashScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(width, locationState),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchRow(),
              const SizedBox(height: 10),
              buildPopularSnackText(),
              const SizedBox(height: 10),
              PopularProductWidget(mainPageState: state),
              const SizedBox(height: 20),
              buildProductsGrid(state),
              const SizedBox(height: 20),
              buildClosestFoodText(),
              const SizedBox(height: 10),
              buildStoresList(state),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(double width, var locationState) {
    return AppBar(
      title: Row(
        children: [
          SizedBox(width: width * 0.3),
          Text(
            locationState.address ?? "위치 정보를 가져오는 중...",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: GREY_PRIMARY_COLOR,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 15,
              color: GREY_PRIMARY_COLOR,
            ),
            onPressed: () async {
              await ref.read(locationProvider.notifier).getCurrentLocation();
              widget.onRefresh();
            },
          ),
        ],
      ),
    );
  }

  Row buildSearchRow() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: CustomTextFormField(
            hintText: "가게명, 음식명 검색!",
            onChanged: (value) => {},
            controller: searchController,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: PRIMARY_ORANGE_COLOR,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                print("검색 버튼 클릭!");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainDataTestScreen(),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Text buildPopularSnackText() {
    return const Text(
      '지금 인기있는 간식이에요!',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: GREY_PRIMARY_COLOR,
        fontSize: 12,
      ),
    );
  }

  GridView buildProductsGrid(MainPageState state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1, // 가로 세로 1:1 비율
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount:
          state.mainData!.productResponseDtoList.length, // 리스트의 길이만큼 아이템 생성
      itemBuilder: (context, index) {
        final product = state.mainData!.productResponseDtoList[index];
        return GestureDetector(
          onTap: () {
            print("이미지 ${product.id} 클릭!");
          },
          child: Container(
            color: HOME_COLOR.withOpacity(0.13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/img/home/home${product.id.toInt()}.png'),
                Text(product.productName),
              ],
            ),
          ),
        );
      },
    );
  }

  Text buildClosestFoodText() {
    return const Text(
      '나와 가장 가까운 음식 Top5',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: GREY_PRIMARY_COLOR,
        fontSize: 12,
      ),
    );
  }

  Column buildStoresList(MainPageState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          List.generate(state.mainData!.storeResponseDtoList.length, (index) {
        final store = state.mainData!.storeResponseDtoList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: PRIMARY_ORANGE_COLOR,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                        store.storeId!.toInt().toString(), // 속성을 직접 사용합니다.
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Image.asset(
              //   state.mainData!.storeResponseDtoList[index].thumbNailImgUrl.toString(),
              //   width: 40,
              //   height: 40,
              // ), // 속성을 직접 사용합니다.
              SizedBox(width: 10),
              Expanded(
                flex: 8,
                child: Text(
                    state.mainData!.storeResponseDtoList[index].name.toString(),
                    style: TextStyle(fontWeight: FontWeight.w400)),
              )
            ],
          ),
        );
      }),
    );
  }
}
