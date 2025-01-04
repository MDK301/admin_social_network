
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<bool> loginWithEmailAndPassword(String email, String password) async {
await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
return true;

}
