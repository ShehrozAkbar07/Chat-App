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
    apiKey: 'AIzaSyDyCxeksYX0LJNpIUvCLMU9uvKzTC5eSjc',
    appId: '1:366409643487:web:6fbfa0859826d90e85406a',
    messagingSenderId: '366409643487',
    projectId: 'chata-45dca',
    authDomain: 'chata-45dca.firebaseapp.com',
    storageBucket: 'chata-45dca.appspot.com',
    measurementId: 'G-3TQJG79RGF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD10bEn-i3qN7ZzKVoIRlxj4yky4a4rGlA',
    appId: '1:366409643487:android:91c4a868c37b6b1985406a',
    messagingSenderId: '366409643487',
    projectId: 'chata-45dca',
    storageBucket: 'chata-45dca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDwNprsm1RHheYfHnmLeOM83CE0CAZKKU',
    appId: '1:366409643487:ios:204b118f8a0df74d85406a',
    messagingSenderId: '366409643487',
    projectId: 'chata-45dca',
    storageBucket: 'chata-45dca.appspot.com',
    iosClientId: '366409643487-54kbo03hl1jtil9u0bj393jid2j9b6d6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDwNprsm1RHheYfHnmLeOM83CE0CAZKKU',
    appId: '1:366409643487:ios:204b118f8a0df74d85406a',
    messagingSenderId: '366409643487',
    projectId: 'chata-45dca',
    storageBucket: 'chata-45dca.appspot.com',
    iosClientId: '366409643487-54kbo03hl1jtil9u0bj393jid2j9b6d6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
