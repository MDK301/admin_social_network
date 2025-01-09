import 'package:admin_social_network/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../login/controller/login_firebase.dart';


class ProfileManager {

  //lấy user profile
  Stream<List<ProfileUser>> getUserProfileStream() {
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

  //lấy user profile
  Stream<List<ProfileUser>> getDeletedUserStream() {
    return FirebaseFirestore.instance
        .collection('tempdeleted')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProfileUser.fromJson(doc.data());
      }).toList()
        ..sort((a, b) => a.email.compareTo(b.email)); // Sắp xếp tăng dần theo email
    });
  }

  //xóa tài khoản tam thoi
  Future<void> tempDeleteUser(String uid) async {
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

  //khôi phục user từ `tempdeleted` về `users`
  Future<void> recoverDeletedUser(String uid) async {
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
  //xóa user trong `tempdeleted` và trong Firebase Auth
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

}

