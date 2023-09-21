import 'dart:async';

import 'package:flutter/material.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/provider/main_provider.dart';

class PopularProductWidget extends StatefulWidget {
  final MainPageState mainPageState;

  PopularProductWidget({required this.mainPageState});

  @override
  _PopularProductWidgetState createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  int _currentPopularProductIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startPopularProductTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startPopularProductTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentPopularProductIndex++;
        if (_currentPopularProductIndex >= widget.mainPageState.mainData!.popularProductsDtoList.length) {
          _currentPopularProductIndex = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 5.3/6,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: GREY_PRIMARY_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${_currentPopularProductIndex + 1} ${widget.mainPageState.mainData!.popularProductsDtoList[_currentPopularProductIndex].productName} ',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black),  // Assuming the default color is black
            ),
            TextSpan(
              text: '↑ Hot!',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: PRIMARY_ORANGE_COLOR),
            ),
          ],
        ),
      )

    );
  }
}