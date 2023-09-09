import 'package:flutter/material.dart';
import 'package:winter_foodies/common/component/next_button.dart';
import 'package:winter_foodies/common/const/colors.dart';

class SelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: BACKGROUND_YELLOW_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.32,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    child: SizedBox(
                      child: Image.asset(
                        'asset/select/select1.png',
                        width: width * 0.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 90, 0, 0),
                          child: Image.asset(
                            'asset/select/winterfoodies_logo.png',
                            width: width * 0.5,
                          ),
                        ),
                        Text(
                          '윈터푸디스',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 43,
                            color: PRIMARY_DARK_COLOR,
                          ),
                        ),
                        Text(
                          '길거리 간식을 쉽게 즐기자!',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: PRIMARY_BROWN_COLOR),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 155, 0, 0),
                    child: Image.asset(
                      'asset/select/select2.png',
                      width: width * 0.2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.37,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 175, 5, 0),
                    child: Image.asset(
                      'asset/select/select3.png',
                      width: width * 0.13,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset(
                        'asset/select/select_boong.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 330),
              child: Image.asset(
                'asset/select/select4.png',
                width: width * 0.3,
              ),
            ),
            NextButton(
                color: PRIMARY_BROWN_COLOR,
                onPressed: () {},
                buttonName: '로그인하기',
                isButtonEnabled: true),
            NextButton(
                color: PRIMARY_ORANGE_COLOR,
                onPressed: () {},
                buttonName: '회원가입하기',
                isButtonEnabled: true),
          ],
        ),
      ),
    );
  }
}
