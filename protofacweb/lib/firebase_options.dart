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
    apiKey: 'AIzaSyBOGUhiJaPcvF2XEMMFkFP_QswPi11lOwQ',
    appId: '1:320926489451:web:926f38d519ac47ad218a2e',
    messagingSenderId: '320926489451',
    projectId: 'protofac-v2',
    authDomain: 'protofac-v2.firebaseapp.com',
    storageBucket: 'protofac-v2.appspot.com',
    measurementId: 'G-9LBT95HT91',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAp2WpMDKG5TI6bqh8ZE8OJM5nFPIRWVuo',
    appId: '1:320926489451:android:d7aa67a6144a6709218a2e',
    messagingSenderId: '320926489451',
    projectId: 'protofac-v2',
    storageBucket: 'protofac-v2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5zKagnUufbGPsbxyAHoh5HCG9jT4BB-s',
    appId: '1:320926489451:ios:6bfb16f895d1f923218a2e',
    messagingSenderId: '320926489451',
    projectId: 'protofac-v2',
    storageBucket: 'protofac-v2.appspot.com',
    iosClientId: '320926489451-1s4l9m6443bhvdbt7ri2a1l4ev46ah2d.apps.googleusercontent.com',
    iosBundleId: 'com.example.protofacweb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5zKagnUufbGPsbxyAHoh5HCG9jT4BB-s',
    appId: '1:320926489451:ios:145f35d6b151f0c6218a2e',
    messagingSenderId: '320926489451',
    projectId: 'protofac-v2',
    storageBucket: 'protofac-v2.appspot.com',
    iosClientId: '320926489451-8gkfortip1llao7jlblf9g3v2j9tmmdb.apps.googleusercontent.com',
    iosBundleId: 'com.example.protofacweb.RunnerTests',
  );
}
