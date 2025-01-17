import 'package:admin_social_network/post/model/post_model.dart';
import 'package:admin_social_network/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../login/controller/login_firebase.dart';
import '../../post/model/comment_model.dart';


class ProfileManager {

  //lấy list user profile cho stream
  Stream<List<ProfileUser>> getListUserProfileStream() {
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

  //lấy user profile cho stream
  Stream<ProfileUser?> getUserProfile(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return ProfileUser.fromJson(snapshot.docs.first.data());
      } else {
        return null; // Trả về null nếu không tìm thấy user
      }
    });
  }



  //xóa tài khoản tam thoi (move user)
  Future<void> tempDeleteUser_00(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        await FirebaseFirestore.instance.collection('tempdeleted').doc(uid).set(userData!);
        await docRef.delete();
        print("User moved to tempdeleted successfully.");
      } else {
        print("User not found in users collection.");
      }
    } catch (e) {
      print("Error moving user to tempdeleted: $e");
    }
  }

  //xóa tài khoản tam thoi (add email user vào temodeleted)
  Future<void> tempDeleteUser(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        final userEmail = userData?['email'] as String?;

        if (userEmail != null) {
          await FirebaseFirestore.instance.collection('tempdeleted').doc(uid).set({
            'email': userEmail, // Chỉ lưu email vào tempdeleted
          });print("User email added to tempdeleted successfully.");
        } else {
          print("User email not found in users collection.");
        }
      } else {
        print("User not found in users collection.");
      }
    } catch (e) {
      print("Error adding user email to tempdeleted: $e");
    }
  }

  //khôi phục user từ `tempdeleted` về `users`
  Future<void> recoverDeletedUser_00(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('tempdeleted').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        await FirebaseFirestore.instance.collection('users').doc(uid).set(userData!);
        await docRef.delete();
        print("User recovered to users collection successfully.");
      } else {
        print("User not found in tempdeleted collection.");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //xóa user trong `tempdeleted`
  Future<void> recoverDeletedUser(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('tempdeleted').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        print("User email removed from tempdeleted successfully.");
      } else {
        print("User email not found in tempdeleted collection.");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //xóa user trong `tempdeleted` và trong Firebase Auth(unable)
  Future<void> deleteUser(String uid) async {
  //   try {
  //     final docRef = FirebaseFirestore.instance.collection('tempdeleted').doc(uid);
  //     final docSnapshot = await docRef.get();
  //
  //     if (docSnapshot.exists) {
  //       final userEmail = docSnapshot.data()?['email'];
  //       if (userEmail != null) {
  //         // Xóa user khỏi Firebase Auth
  //         final user = await FirebaseAuth.instance.getUserByEmail(userEmail);
  //         await FirebaseAuth.instance.deleteUser(user.uid);
  //
  //         // Xóa user khỏi `tempdeleted`
  //         await docRef.delete();
  //
  //
  //
  //         // Đăng nhập người dùng
  //         var userCredential = await signInWithEmailAndPassword(auth, email, password);
  //         const user = userCredential.user;
  //
  //         // Xóa tài khoản
  //         await user.delete();
  //         print("User deleted successfully from tempdeleted and Firebase Auth.");
  //       } else {
  //         print("Email not found for the user.");
  //       }
  //     } else {
  //       print("User not found in tempdeleted collection.");
  //     }
  //   } catch (e) {
  //     print("Error deleting user: $e");
  //   }
  }

//lay noi dung trong temp_deleted
  Stream<List<String>> getTempDeletedEmailsStream() {
    return FirebaseFirestore.instance
        .collection('tempdeleted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc['email'] as String).toList());
  }

  //hàm này để quản lý cmt của người đó
  Stream<List<Comment>> getCommentsByUser(String uid) {
    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .map((snapshot) {
      List<Comment> userComments = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final comments = data['comments'] as List<dynamic>? ?? [];
        for (var comment in comments) {
          if (comment['userId'] == uid) {
            userComments.add(Comment.fromJson(comment as Map<String, dynamic>));
          }
        }
      }
      return userComments;
    });
  }


}

