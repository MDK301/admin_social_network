
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
    return userCredential.user;
  } catch (e) {
    print('Lỗi đăng nhập: $e');
    return null;
  }
}
