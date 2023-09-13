import 'package:flutter/material.dart';
import 'package:winter_foodies/common/component/custom_text_form_field.dart';
import 'package:winter_foodies/common/component/next_button.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/const/text.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';

class FindEmailScreen extends StatefulWidget {
  const FindEmailScreen({super.key});

  @override
  State<FindEmailScreen> createState() => _FindEmailScreenState();
}

class _FindEmailScreenState extends State<FindEmailScreen> {

  bool _isLoading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '아이디 찾기',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Image.asset('asset/img/home/home1.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '등록된 휴대폰 번호로 찾기',
                style: textBrownStyle,
              ),
            ),
            Text(
              '휴대폰 번호',
              style: signupReqStyle,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: CustomTextFormField(
                    controller: phoneController,
                    hintText: '번호를 입력해 주세요(' '-' '포함)',
                    onChanged: (String value) {

                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 10, 0),
                    child: ElevatedButton(
                        onPressed: () {
                          // TODO: 인증번호 보내기 로직 구현
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_ORANGE_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                      ),
                      child: Text(
                        '인증',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '인증번호',
              style: signupReqStyle,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: CustomTextFormField(
                    controller: checkController,
                    hintText: '인증번호를 입력해주세요',
                    onChanged: (String value) {

                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 10, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 인증번호 보내기 로직 구현
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_ORANGE_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 30),
              child: NextButton(
                color: PRIMARY_BROWN_COLOR,
                buttonName: _isLoading ? '로딩중...' : '아이디찾기', // 버튼 텍스트 조건부 설정
                isButtonEnabled:
                _isButtonEnabled && !_isLoading, // 로딩 중일 때 버튼 비활성화
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // 로딩 중 상태로 변경
                  });
                  try {
                    // await ref.read(userMeProvider.notifier).login(
                    //   username: emailController.text.trim(),
                    //   password: passwordController.text.trim(),
                    // );

                    print('성공적 아이디 찾기');
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => RootTab(),
                    //   ),
                    // );
                  } catch (e) {
                    // 로그인 실패 시 예외 처리
                  } finally {
                    setState(() {
                      _isLoading = false; // 로딩 상태 해제
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
