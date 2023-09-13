import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String? address;
  final VoidCallback onRefresh;

  const HomeScreen({Key? key, this.address, required this.onRefresh}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ... 나머지 코드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address ?? "위치 정보를 가져오는 중..."),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: widget.onRefresh,
          )
        ],
      ),
      // ... 나머지 코드
    );
  }
}

