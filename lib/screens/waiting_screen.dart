import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Đang đăng nhập....'),
          CircularProgressIndicator(
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
