// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyBu-rzDh0tW0j5ramTKuhZUnT-INQiVU-0',
    appId: '1:846295050222:web:3e291eabdd4054b7d850ff',
    messagingSenderId: '846295050222',
    projectId: 'darkgreen-75353',
    authDomain: 'darkgreen-75353.firebaseapp.com',
    storageBucket: 'darkgreen-75353.appspot.com',
    measurementId: 'G-X5B8C3XQKP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBA1xf1HSpWvQ6acHhZhmXEo6KMBKcrIKo',
    appId: '1:846295050222:android:205bff1b7dcf0542d850ff',
    messagingSenderId: '846295050222',
    projectId: 'darkgreen-75353',
    storageBucket: 'darkgreen-75353.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCx6OejC2gKPsdOpy2RuphkfW57HNAG0hA',
    appId: '1:846295050222:ios:cd9d4d7c849998f4d850ff',
    messagingSenderId: '846295050222',
    projectId: 'darkgreen-75353',
    storageBucket: 'darkgreen-75353.appspot.com',
    iosClientId: '846295050222-n48a9ruqgmhkoho1pfskkvlvqp5vod1c.apps.googleusercontent.com',
    iosBundleId: 'com.example.darkgreen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCx6OejC2gKPsdOpy2RuphkfW57HNAG0hA',
    appId: '1:846295050222:ios:cd9d4d7c849998f4d850ff',
    messagingSenderId: '846295050222',
    projectId: 'darkgreen-75353',
    storageBucket: 'darkgreen-75353.appspot.com',
    iosClientId: '846295050222-n48a9ruqgmhkoho1pfskkvlvqp5vod1c.apps.googleusercontent.com',
    iosBundleId: 'com.example.darkgreen',
  );
}