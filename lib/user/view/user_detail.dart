import 'package:admin_social_network/post/model/post_model.dart';
import 'package:flutter/material.dart';

import '../../post/model/comment_model.dart';
import '../controller/user_manager_firebase.dart';
import '../model/user_model.dart';

class UserDetail extends StatelessWidget {
  final ProfileUser profileUser;

  const UserDetail({super.key, required this.profileUser});

  @override
  Widget build(BuildContext context) {
    final profileManager = ProfileManager();

    return Scaffold(
      appBar: AppBar(
        title: Text(profileUser.email.toString()),
        actions: [
          //Icon xóa
          StreamBuilder<List<String>>(
              stream: profileManager.getTempDeletedEmailsStream(),
              builder: (context, snapshot) {
                String status = "ACTIVE";
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  final tempDeletedEmails = snapshot.data!;
                  if (tempDeletedEmails.contains(profileUser.email)) {
                    status = "ON LOCK";
                  }
                }
                return TextButton(
                  onPressed: () {
                    try {
                      final tempDeletedEmails = snapshot.data!;
                      if (tempDeletedEmails.contains(profileUser.email)) {
                        profileManager.recoverDeletedUser(profileUser.uid);
                      }else{
                        profileManager.tempDeleteUser(profileUser.uid);
                      }


                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lỗi: ${e.toString()}')),
                      );
                    }
                  },
                  child: StreamBuilder<List<String>>(
                    stream: profileManager.getTempDeletedEmailsStream(),
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          Text(status, style: TextStyle(
                                color: status == "ACTIVE"
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
        ],
      ),
      body: Padding(
        //khoảng cách chung quanh ^
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            //thông tin Profile
            Row(
              children: [
                StreamBuilder<ProfileUser?>(
                  stream:  profileManager.getUserProfile(profileUser.uid),
                  builder: (context, snapshot) {

                    if (snapshot.hasData && snapshot.data != null) {

                      // Kiểm tra xem dữ liệu có sẵn và khác null hay không
                      final user = snapshot.data!;
                      return Text("Name: "+ user.name ,style: TextStyle(fontSize: 20),);

                    } else if (snapshot.hasError) {
                      // Xử lý lỗi
                      return Center(child: Text('Lỗi: ${snapshot.error}'));
                    } else {
                      // Hiển thị chỉ báo tải
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                ),
              ],
            ),

            //thông tin ngoài profile
            Text("COMMENT LIST"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.grey, width: 1.0), // Khung viền
                borderRadius: BorderRadius.circular(12.0), // Bo góc (tuỳ chọn)
              ),
              child: StreamBuilder<List<Comment>>(
                stream: profileManager.getCommentsByUser(profileUser.uid), // Stream để lấy dữ liệu comment
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Hiển thị khi đang tải
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}')); // Hiển thị khi có lỗi
                  }

                  final comments = snapshot.data;

                  if (comments == null || comments.isEmpty) {
                    return const Center(child: Text('Không có comment nào.')); // Không có comment
                  }

                  // Hiển thị danh sách comment
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(comment.userName[0].toUpperCase()), // Chữ cái đầu tên user
                          ),
                          title: Text(comment.text),
                          subtitle: Text(
                            'By: ${comment.userName} - ${comment.timestamp.toLocal()}',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
