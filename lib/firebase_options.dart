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
    apiKey: 'AIzaSyAOdoaBDZ8GdsRAcVgpbhobAfBMPafqhaY',
    appId: '1:567197121691:web:89c8d5d2a5c1682b1dda3e',
    messagingSenderId: '567197121691',
    projectId: 'social-media-app-6d0e6',
    authDomain: 'social-media-app-6d0e6.firebaseapp.com',
    storageBucket: 'social-media-app-6d0e6.appspot.com',
    measurementId: 'G-95816KQZZN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzX0pmWmdnTMR6oMWSrkQ_JTyzc6QgEUY',
    appId: '1:567197121691:android:bde1717ff333a0a11dda3e',
    messagingSenderId: '567197121691',
    projectId: 'social-media-app-6d0e6',
    storageBucket: 'social-media-app-6d0e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjwH4-Ed39LE0i1rWb-EfaVIidtDVezqg',
    appId: '1:567197121691:ios:08a39f94a129ad771dda3e',
    messagingSenderId: '567197121691',
    projectId: 'social-media-app-6d0e6',
    storageBucket: 'social-media-app-6d0e6.appspot.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjwH4-Ed39LE0i1rWb-EfaVIidtDVezqg',
    appId: '1:567197121691:ios:71afde4525d3a17b1dda3e',
    messagingSenderId: '567197121691',
    projectId: 'social-media-app-6d0e6',
    storageBucket: 'social-media-app-6d0e6.appspot.com',
    iosBundleId: 'com.example.socialMediaApp.RunnerTests',
  );
}
