import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/component/custom_text_form_field.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/const/text.dart';
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
  TextEditingController searchController = TextEditingController();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final locationState = ref.watch(locationProvider); // 상태를 관찰하려면 watch를 사용
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: width * 0.3,
            ),
            Text(
              locationState.address ?? "위치 정보를 가져오는 중...",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            IconButton(
              icon: Icon(Icons.refresh, size: 15),
              onPressed: () async {
                await ref.read(locationProvider.notifier).getCurrentLocation();
                widget.onRefresh();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 8, // 8의 비율로 차지
                    child: CustomTextFormField(
                      hintText: "가게명, 음식명 검색!",
                      onChanged: (value) => {},
                      controller: searchController,
                    ),
                  ),
                  Expanded(
                    flex: 2, // 2의 비율로 차지
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: PRIMARY_ORANGE_COLOR,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // 검색 버튼이 클릭됐을 때의 코드를 여기에 작성하세요.
                          print("검색 버튼 클릭!");
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10), // 간격 추가

              Text(
                '지금 인기있는 간식이에요!',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: GREY_PRIMARY_COLOR,
                  fontSize: 12,
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '1. 계란빵 Hot!',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1, // 가로 세로 1:1 비율
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("이미지 $index 클릭!");
                    },
                    child: Container(
                      color: HOME_COLOR,
                      child: Image.asset('asset/img/home/home${index + 1}.png'),
                    ), // 이미지 경로를 적절히 수정해주세요.
                  );
                },
              ),

              SizedBox(height: 20),

              Text(
                '나와 가장 가까운 음식 Top5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: GREY_PRIMARY_COLOR,
                  fontSize: 12,
                ),
              ),

              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '${index + 1}. 음식이름 ${index + 1}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
