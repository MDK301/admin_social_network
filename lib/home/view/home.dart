import 'package:admin_social_network/home/controller/home_firebase.dart';
import 'package:admin_social_network/login/view/component/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trang chủ')),
      body: Center(
        child: Row(
          children: [
            Text('Chào mừng bạn đến với trang chủ!'),
            MyButton(onTap: Logout(), text: "Logout")
          ],
        ),

      ),
    );
  }
}
