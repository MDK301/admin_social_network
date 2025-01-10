import 'package:admin_social_network/user/controller/user_manager_firebase.dart';
import 'package:admin_social_network/user/model/user_model.dart';
import 'package:admin_social_network/user/view/user_detail.dart';
import 'package:flutter/material.dart';

// chay den User detail

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final profileManager = ProfileManager();
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách người dùng"),
      ),
      body: StreamBuilder<List<ProfileUser>>(
        stream: profileManager.getListUserProfileStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {

            // Kiểm tra xem dữ liệu có sẵn và khác null hay không
            final user = snapshot.data!; // Sử dụng toán tử khẳng định null một cách an toàn
            String status="Active";
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(user[index].name, style: TextStyle(color: Colors.grey)),
                          StreamBuilder<List<String>>(
                            stream:profileManager.getTempDeletedEmailsStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasData) {
                                final tempDeletedEmails = snapshot.data!;
                                if (tempDeletedEmails
                                    .contains(user[index].email)) {
                                  status = "On lock";
                                }
                              }
                              return Row(
                                children: [
                                  const Text("Status: "),
                                  Text(
                                    status,
                                    style: TextStyle(
                                        color: status == "Active"
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
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
