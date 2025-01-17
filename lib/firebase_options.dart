// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQIO46i5Wgtun686vijLykjPKy_PoCyQs',
    appId: '1:740307927813:web:0e31037f6f7281a7c36d6c',
    messagingSenderId: '740307927813',
    projectId: 'note-24dea',
    authDomain: 'note-24dea.firebaseapp.com',
    databaseURL: 'https://note-24dea-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'note-24dea.appspot.com',
    measurementId: 'G-ZGKGBHP6MN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqTXTEy-4wtiqGZOZ6gHfyYOBztXKTn34',
    appId: '1:740307927813:android:493fd1c79c75ca8cc36d6c',
    messagingSenderId: '740307927813',
    projectId: 'note-24dea',
    databaseURL: 'https://note-24dea-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'note-24dea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_lCQIi0om3-AKX-1v486IvYxx8PQBzOY',
    appId: '1:740307927813:ios:04d2e1eb7b97f811c36d6c',
    messagingSenderId: '740307927813',
    projectId: 'note-24dea',
    databaseURL: 'https://note-24dea-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'note-24dea.appspot.com',
    iosBundleId: 'com.example.adminSocialNetwork',
  );
}
