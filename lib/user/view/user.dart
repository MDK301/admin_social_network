import 'package:admin_social_network/user/controller/user_manager_firebase.dart';
import 'package:admin_social_network/user/model/user_model.dart';
import 'package:admin_social_network/user/view/user_detail.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    final profileManager = ProfileManager();
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý người dùng"),
      ),
      body: StreamBuilder<List<ProfileUser>>(
        stream: profileManager.getProfileUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // Kiểm tra xem dữ liệu có sẵn và khác null hay không
            final user = snapshot.data!; // Sử dụng toán tử khẳng định null một cách an toàn
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(color: Colors.grey, width: 1.0), // Khung viền
                      borderRadius: BorderRadius.circular(12.0), // Bo góc (tuỳ chọn)
                    ),
                    child: ListTile(
                      title: Text(user[index].email,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle:
                      Text(user[index].name,style: TextStyle(color: Colors.grey),),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserDetail(profileUser: user[index],)),
                        );
                      },

                    ),
                  )
                );
              },
            );
          } else if (snapshot.hasError) {
            // Xử lý lỗi
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            // Hiển thị chỉ báo tải
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
