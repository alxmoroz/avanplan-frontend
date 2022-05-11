// Copyright (c) 2022. Alexandr Moroz

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/colors.dart';
import 'components/splash.dart';
import 'extra/services.dart';
import 'l10n/generated/l10n.dart';
import 'views/auth/login_view.dart';
import 'views/main/main_view.dart';

Future main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  // certs
  if (!kIsWeb) {
    final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  runApp(App());
}

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Observer(builder: (_) => loginController.authorized ? MainView() : LoginView());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness platformBrightness = WidgetsBinding.instance!.window.platformBrightness;

    return Theme(
      data: ThemeData(
        brightness: platformBrightness,
        primarySwatch: platformBrightness == Brightness.light ? darkTealColorMaterial : tealColorMaterial,
      ),
      child: CupertinoApp(
        home: FutureBuilder(
          future: getIt.allReady(),
          builder: (_, snapshot) => snapshot.hasData ? RootView() : const SplashScreen(),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: const CupertinoThemeData(primaryColor: mainColor),
      ),
    );
  }
}
