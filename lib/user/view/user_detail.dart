import 'package:flutter/material.dart';

import '../controller/user_manager_firebase.dart';
import '../model/user_model.dart';

class UserDetail extends StatelessWidget {
  final ProfileUser profileUser;

  const UserDetail({super.key,required this.profileUser});

  @override
  Widget build(BuildContext context) {
    final profileManager = ProfileManager();

    return Scaffold(
      appBar: AppBar(title: Text(profileUser.email.toString()),actions: [
        IconButton(
          icon: const Icon(Icons.auto_delete),
          onPressed: () {
            try {
              profileManager.tempDeleteUser(profileUser.uid);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginScreen()),
              // );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lỗi: ${e.toString()}')),
              );
            }
          },
          tooltip: 'Logout',
        ),
      ],),
    );
  }
}
