// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'L2_data/services/firebase_options.dart';
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
  try {
    await Firebase.initializeApp(options: firebasePlatformOptions);
  } catch (e) {
    print('Firebase.initializeApp ERROR: $e');
  }

  // certs
  if (!kIsWeb) {
    final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  usePathUrlStrategy();

  runApp(App());
}

final rootKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
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

    const _DEBUG_BANNER = true;

    return FutureBuilder(
      future: getIt.allReady(),
      builder: (_, snapshot) => snapshot.hasData
          ? MaterialApp(
              debugShowCheckedModeBanner: _DEBUG_BANNER,
              theme: themeData,
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              navigatorKey: rootKey,
              onGenerateRoute: MTRouter.generateRoute,
              navigatorObservers: [MTRouteObserver()],
            )
          : Container(
              color: b2Color.resolve(context),
              child: const Center(child: MTCircularProgress(color: mainColor, size: P10)),
            ),
    );
  }
}
