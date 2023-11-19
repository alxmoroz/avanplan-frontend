// Copyright (c) 2023. Alexandr Moroz

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

FirebaseOptions get firebasePlatformOptions {
  const senderId = '1039142486698';
  const projectId = 'gercules';
  const storageBucket = 'gercules.appspot.com';

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCLtgDe0Vlrljnjpc9anOWJ21L_gpfo7UY',
      appId: '1:1039142486698:ios:8c476fe613086b786086d3',
      messagingSenderId: senderId,
      projectId: projectId,
      storageBucket: storageBucket,
      iosClientId: '1039142486698-e0obup6endeh0cgl171g8p9rg1knf39a.apps.googleusercontent.com',
      iosBundleId: 'team.moroz.avanplan',
    );
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCu8QMmxAsi3MUyr9GqfubUwD91wyl7ros',
      appId: kReleaseMode ? '1:1039142486698:android:09d1a23bdbf5d0556086d3' : '1:1039142486698:android:dffc0090376a0ca96086d3',
      messagingSenderId: senderId,
      projectId: projectId,
      storageBucket: storageBucket,
    );
  } else {
    return const FirebaseOptions(
      apiKey: 'AIzaSyDqGoX0JhWv-GUruxumiurGunvLGNuvQlI',
      appId: '1:1039142486698:web:e6fb6ae052e9219e6086d3',
      messagingSenderId: senderId,
      projectId: projectId,
      authDomain: 'gercules.firebaseapp.com',
      storageBucket: storageBucket,
      measurementId: 'G-Z3B7TNQSJM',
    );
  }
}
