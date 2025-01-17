import 'package:admin_social_network/home/controller/home_firebase.dart';
import 'package:admin_social_network/login/view/login.dart';
import 'package:admin_social_network/post/view/all_report_post.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            //canh đều
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //quản lý người dùng
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserList()),
                  );
                },
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Text(
                            "Quản lý người dùng",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.person,
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //duyệt bài viết
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllReportPost()),
                  );
                },
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Text(
                            "Duyệt bài viết",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.format_indent_decrease_sharp,
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
