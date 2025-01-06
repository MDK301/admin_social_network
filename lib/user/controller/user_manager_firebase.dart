import 'package:admin_social_network/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileManager {

  //lấy user profile
  Stream<List<ProfileUser>> getProfileUserStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProfileUser.fromJson(doc.data());
      }).toList()
        ..sort((a, b) => a.email.compareTo(b.email)); // Sắp xếp tăng dần theo email
    });
  }

  //xóa tài khoản
  Future<void> deleteUser(String uid) async {
     FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProfileUser.fromJson(doc.data());
      }).toList()
        ..sort((a, b) => a.email.compareTo(b.email)); // Sắp xếp tăng dần theo email
    });
  }

}

