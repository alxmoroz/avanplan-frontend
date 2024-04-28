// Copyright (c) 2024. Alexandr Moroz

import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // ignore: depend_on_referenced_packages

import 'L2_data/services/firebase_options.dart';
import 'L2_data/services/platform.dart';
import 'L3_app/components/background.dart';
import 'L3_app/components/circular_progress.dart';
import 'L3_app/components/colors.dart';
import 'L3_app/components/colors_base.dart';
import 'L3_app/components/constants.dart';
import 'L3_app/extra/router.dart';
import 'L3_app/extra/services.dart';
import 'L3_app/l10n/generated/l10n.dart';

Future main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  try {
    await Firebase.initializeApp(options: firebasePlatformOptions);
  } catch (e) {
    if (kDebugMode) {
      print('Firebase.initializeApp ERROR: $e');
    }
  }

  // certs
  if (!isWeb) {
    final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  usePathUrlStrategy();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ];

    final supportedLocales = S.delegate.supportedLocales;
    final themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: mainColor.resolve(context),
        primary: mainColor.resolve(context),
        brightness: MediaQuery.platformBrightnessOf(context),
        background: b2Color.resolve(context),
        surfaceTint: b2Color.resolve(context),
        surface: b3Color.resolve(context),
      ),
      fontFamily: 'RobotoAvanplan',
      useMaterial3: true,
    );

    return FutureBuilder(
      future: getIt.allReady(),
      builder: (_, snapshot) => snapshot.hasData
          ? MaterialApp.router(
              debugShowCheckedModeBanner: true,
              theme: themeData,
              scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
                if (isWeb) PointerDeviceKind.mouse,
                ...const MaterialScrollBehavior().dragDevices,
              }),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              routerConfig: router,
              onGenerateTitle: (context) => loc.app_title,
            )
          : const MTBackgroundWrapper(Center(child: MTCircularProgress(size: P10))),
    );
  }
}
