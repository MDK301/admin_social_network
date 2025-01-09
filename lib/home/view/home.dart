import 'package:admin_social_network/home/controller/home_firebase.dart';
import 'package:admin_social_network/login/view/login.dart';
import 'package:flutter/material.dart';

import '../../user/view/user_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              try {
                logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi: ${e.toString()}')),
                );
              }
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0), // Khung viền
              borderRadius: BorderRadius.circular(12.0), // Bo góc (tuỳ chọn)
            ),
            child: ListTile(
              title: Text("Quản lý người dùng"),
              onTap: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserList()),
              );},
            ),
          )


        ],
      ),
    );
  }
}
