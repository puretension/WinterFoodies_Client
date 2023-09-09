import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/component/next_button.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/const/text.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';
import 'package:winter_foodies/user/repository/auth_repository.dart';
import 'package:winter_foodies/user/view/login_screen.dart';

extension InputValidate on String {
  // 이메일 포맷 검증
  bool isValidEmailFormat() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  // 대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (010-1234-5678)
  bool isValidPhoneNumberFormat() {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(this);
  }
}

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  bool isEmailValid = false;
  bool isNameValid = false;
  bool isNickNameValid = false;
  bool isPhoneNumValid = false;
  bool isPasswordValid = false;
  bool isButtonEnabled = false;

  String? nameErrorText;
  String? nicknameErrorText;
  String? ageErrorText;
  String? phoneNumErrorText;
  // String? jobErrorText;
  String? emailErrorText;
  String? emailValidText;
  String? accountErrorText;

  void checkNameEnabled() {
    String name = nameController.text.trim();
    bool isValid = RegExp(r'^[a-zA-Z가-힣]{2,}$').hasMatch(name);

    setState(() {
      isNameValid = isValid;
      nameErrorText = isValid ? null : '영문자 또는 한글로 2자 이상 입력해 주세요';
    });
  }

  void checkPhoneNumEnabled() {
    String number = phoneNumController.text.trim();
    bool isValid = number.isValidPhoneNumberFormat();

    setState(() {
      isPhoneNumValid = isValid;
      phoneNumErrorText = isValid ? null : '올바른 전화번호 형식이 아닙니다';
    });
    checkButtonEnabled();
  }

  void checkButtonEnabled() {
    setState(() {
      isButtonEnabled = isEmailValid &&
          isPasswordValid &&
          isNameValid &&
          isNickNameValid &&
          isPhoneNumValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원가입',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'asset/img/loading/loading.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '회원정보를 입력해주세요',
                  style: textBrownStyle,
                ),
              ),
              Text(
                '이름',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: nameController,
                hintText: '본인의 이름을 입력해 주세요',
                onChanged: (String value) {
                  checkNameEnabled();
                },
                errorText: isNameValid ? null : nameErrorText,
              ),
              Text(
                '이메일',
                style: signupReqStyle,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5, // 비율을 사용하여 width를 조절
                    child: CustomTextFormField(
                      controller: emailController,
                      hintText: '이메일을 입력헤주세요',
                      onChanged: (String value) {},
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(authRepositoryProvider)
                              .checkEmail(emailController.text)
                              .then((response) {
                            if (response != null &&
                                response.status == "success") {
                              isEmailValid = true;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(response.message),
                                    content: Text(response.message ?? ""),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              isEmailValid = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          response?.message ?? "중복된 아이디 입니다")));
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_ORANGE_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        ),
                        child: Text(
                          '중복확인',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '닉네임',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: nicknameController,
                hintText: '닉네임을 입력해 주세요',
                onChanged: (String value) {
                  checkNameEnabled();
                },
                errorText: isNickNameValid ? null : nameErrorText,
              ),
              Text(
                '전화번호',
                style: signupReqStyle,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5, // 비율을 사용하여 width를 조절
                    child: CustomTextFormField(
                      controller: phoneNumController,
                      hintText: '번호를 입력해 주세요(' '-' '제외)',
                      onChanged: (String value) {
                        checkPhoneNumEnabled();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 44, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(authRepositoryProvider)
                              .checkEmail(emailController.text)
                              .then((response) {
                            if (response != null &&
                                response.status == "success") {
                              isEmailValid = true;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(response.message),
                                    content: Text(response.message ?? ""),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              isEmailValid = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          response?.message ?? "중복된 아이디 입니다")));
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_ORANGE_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // 모서리 깎기
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                        ),
                        child: Text(
                          '인증',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '비밀번호',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: '6자 이상의 영문/숫자 조합',
                onChanged: (String value) {},
                obscureText: true,
              ),
              Text(
                '비밀번호 확인',
                style: signupReqStyle,
              ),
              CustomTextFormField(
                controller: passwordController,
                hintText: '재입력해 주세요',
                onChanged: (String value) {},
                obscureText: true,
              ),
              NextButton(
                color: PRIMARY_BROWN_COLOR,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                buttonName: '가입완료!',
                isButtonEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? name;
  final int? textFieldMinLine;
  final bool? enable;
  final int? maxLines; // 추가
  final bool? expands; // 추가

  const CustomTextFormField({
    this.enable,
    required this.onChanged,
    this.textFieldMinLine = 1,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    this.hintText,
    this.controller,
    this.name,
    this.maxLines, // 추가
    this.expands, // 추가
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 14, 6),
      child: TextFormField(
        enabled: widget.enable ?? true,
        onTap: () {
          setState(() {
            showErrorText = false;
          });
        },
        controller: widget.controller,
        cursorColor: CURSOR_COLOR,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        minLines:
            widget.expands == true ? null : widget.textFieldMinLine, // 수정된 부분
        maxLines: widget.expands == true ? null : (widget.maxLines ?? 1),
        expands: widget.expands ?? false, // 연결
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: true, // Added this line to enable background color
          fillColor: Colors
              .white, // Added this line to set the background color to white
          contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: WHITE_LIGHT4_COLOR,
          ),
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: DARK_PRIMARY_COLOR,
            ),
          ),
          enabledBorder: baseBorder,
        ),
      ),
    );
  }
}
