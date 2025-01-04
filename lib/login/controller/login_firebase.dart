
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


Future<User?> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    var userDoc = await firebaseFirestore
        .collection('admin')
        .where('email', isEqualTo: userCredential.user!.email)
        .get(); // Kiểm tra xem có tài liệu nào được trả về không
    if (userDoc.docs.isEmpty) {
      throw Exception('Đây không phải là Email của Admin');
    }


    return userCredential.user;
  } catch (e) {
    throw Exception('Lỗi đăng nhập: $e');

    return null;
  }
}
