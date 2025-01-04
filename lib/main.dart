import 'package:admin_social_network/firebase_options.dart';
import 'package:admin_social_network/home/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/view/login.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if the user is currently signed in
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    runApp(const Logined());
  } else {
    runApp(const NotLogin());
  }


}
class NotLogin extends StatelessWidget {const NotLogin({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp( // Hoặc WidgetsApp
    home: LoginScreen(),
  );
}
}
class Logined extends StatelessWidget {const Logined({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp( // Hoặc WidgetsApp
    home: HomeScreen(),
  );
}
}
