import 'package:admin_social_network/user/controller/user_manager_firebase.dart';
import 'package:admin_social_network/user/model/user_model.dart';
import 'package:flutter/material.dart';

class UserManager extends StatelessWidget {
  const UserManager({super.key});

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý người dùng"),
      ),
      body: StreamBuilder<List<ProfileUser>>(
          stream: ProfileManager.getProfileUserStream(), builder: (context, snapshot) {
            final user=snapshot.data;
            return ListView.builder(
              itemCount: user!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text("1"),
                      Text(user[index].email),
                    ],
                  ),
                );
              },
            );
      }),
    );
  }
}
