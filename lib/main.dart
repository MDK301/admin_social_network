import 'package:admin_social_network/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/view/login.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp( // Hoặc WidgetsApp
    home: LoginScreen(),
  );
}
}
