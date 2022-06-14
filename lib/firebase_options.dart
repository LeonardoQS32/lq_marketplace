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
    apiKey: 'AIzaSyAvMnZ-ODxKgGfW1nxfqdmaXkzKEAoLdT8',
    appId: '1:743884451490:web:a70618c6769cea9b2d31fb',
    messagingSenderId: '743884451490',
    projectId: 'mercado-b50b2',
    authDomain: 'mercado-b50b2.firebaseapp.com',
    databaseURL: 'https://mercado-b50b2-default-rtdb.firebaseio.com',
    storageBucket: 'mercado-b50b2.appspot.com',
    measurementId: 'G-S3DGBC2F2R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlKorVr7TKrB5Ta4ylAQDQhbB3paVKbCE',
    appId: '1:743884451490:android:89c18c7e3c585aec2d31fb',
    messagingSenderId: '743884451490',
    projectId: 'mercado-b50b2',
    databaseURL: 'https://mercado-b50b2-default-rtdb.firebaseio.com',
    storageBucket: 'mercado-b50b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUmiyC46mnyB120b2_XNVHr8eaBB1zbO4',
    appId: '1:743884451490:ios:d2a9eb2b999b8dae2d31fb',
    messagingSenderId: '743884451490',
    projectId: 'mercado-b50b2',
    databaseURL: 'https://mercado-b50b2-default-rtdb.firebaseio.com',
    storageBucket: 'mercado-b50b2.appspot.com',
    iosClientId: '743884451490-2qqbm67ups3fscjqftnn2bn0crn3n4qr.apps.googleusercontent.com',
    iosBundleId: 'com.projetos.leonardoqs.lqMarketplace',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUmiyC46mnyB120b2_XNVHr8eaBB1zbO4',
    appId: '1:743884451490:ios:d2a9eb2b999b8dae2d31fb',
    messagingSenderId: '743884451490',
    projectId: 'mercado-b50b2',
    databaseURL: 'https://mercado-b50b2-default-rtdb.firebaseio.com',
    storageBucket: 'mercado-b50b2.appspot.com',
    iosClientId: '743884451490-2qqbm67ups3fscjqftnn2bn0crn3n4qr.apps.googleusercontent.com',
    iosBundleId: 'com.projetos.leonardoqs.lqMarketplace',
  );
}
