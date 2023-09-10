import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/component/custom_text_form_field.dart';
import 'package:winter_foodies/common/component/next_button.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/const/text.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';
import 'package:winter_foodies/user/provider/user_me_provider.dart';
import 'package:winter_foodies/user/view/email_screen.dart';
import 'package:winter_foodies/user/view/home_screen.dart';
import 'package:winter_foodies/user/view/password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false; // 로딩 중 상태를 나타내는 변수
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _emailErrorText;
  String? _passwordErrorText;

  void _checkButtonEnabled() {
    bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text);
    bool isPasswordValid =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$').hasMatch(passwordController.text);

    setState(() {
      _emailErrorText = isEmailValid ? null : '올바른 이메일 형식이 아닙니다';
      _passwordErrorText = isPasswordValid ? null : '올바른 비밀번호 형식이 아닙니다';
      _isButtonEnabled = isEmailValid && isPasswordValid;
    });
    // navigateToNextScreen(); // 수정된 부분
  }

  @override
  void initState() {
    emailController.addListener(_checkButtonEnabled);
    passwordController.addListener(_checkButtonEnabled);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'asset/select/select_change_boong.png',
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  '로그인',
                  style: textBrownStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 300),
                child: Text(
                  '이메일',
                  style: signupReqStyle,
                ),
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: '가입된 이메일을 입력해주세요',
                onChanged: (String value) {},
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 300),
                child: Text(
                  '비밀번호',
                  style: signupReqStyle,
                ),
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: '6자 이상의 영문/숫자 조합',
                onChanged: (String value) {},
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: NextButton(
                  color: PRIMARY_BROWN_COLOR,
                  buttonName: _isLoading ? '로그인 중...' : '로그인', // 버튼 텍스트 조건부 설정
                  isButtonEnabled:
                      _isButtonEnabled && !_isLoading, // 로딩 중일 때 버튼 비활성화
                  onPressed: () async {
                    setState(() {
                      _isLoading = true; // 로딩 중 상태로 변경
                    });
                    try {
                      await ref.read(userMeProvider.notifier).login(
                            username: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                      print('성공적 로그인');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RootTab(),
                        ),
                      );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 중앙 정렬
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FindEmailScreen(),
                        ),
                      );
                    },
                    child: Text('아이디찾기', style: socialReq2Style),
                  ),
                  Text('|', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FindPasswordScreen(),
                        ),
                      );
                    },
                    child: Text('비밀번호찾기', style: socialReq2Style),
                  ),
                ],
              ),
              Divider(
                color: GREY_PRIMARY_COLOR,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'SNS 로그인',
                  style: socialReqStyle,
                ),
              ),
              Row(
                children: [
                  // Image.asset('asset/icon/login/naver.svg',width: width * 0.5,),
                  // Image.asset('asset/icon/login/kakao.png',width: width * 0.3,),
                  // Image.asset('asset/icon/login/google.png',width: width * 0.3,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
